import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_voice_list/config/storage_manager.dart';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  List<FileSystemEntity> files = [];
  Directory parentDir;
  ScrollController controller = ScrollController();
  List<double> position = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          parentDir?.path == StorageManager.externalDirectory.path
              ? 'SD Card'
              : p.basename(parentDir.path),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffeeeeee),
        elevation: 0.0,
        leading: parentDir?.path == StorageManager.externalDirectory.path
            ? Container()
            : IconButton(icon: Icon(Icons.chevron_left, color: Colors.black)),
      ),
      body: files.length == 0
          ? Center(child: Text('The folder is empty'))
          : Scrollbar(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: controller,
                itemCount: files.length,
                itemBuilder: (BuildContext context, int index) {
                  if (FileSystemEntity.isFileSync(files[index].path))
                    return _buildFileItem(files[index]);
                  else
                    return _buildFolderItem(files[index]);
                },
              ),
            ),
    );
  }

  Widget _buildFileItem(FileSystemEntity file) {
    String modifiedTime = DateFormat('yyyy-MM-dd HH:mm:ss', 'zh_CN')
        .format(file.statSync().modified.toLocal());

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          title: Text(file.path.substring(file.parent.path.length + 1)),
          subtitle: Text('$modifiedTime  ', style: TextStyle(fontSize: 12.0)),
        ),
      ),
      onTap: () {},
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child:
                      Text('重命名', style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {},
                ),
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child: Text('删除', style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {},
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFolderItem(FileSystemEntity file) {
    String modifiedTime = DateFormat('yyyy-MM-dd HH:mm:ss', 'zh_CN')
        .format(file.statSync().modified.toLocal());

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/folder.png'),
          title: Row(
            children: <Widget>[
              Expanded(
                  child:
                      Text(file.path.substring(file.parent.path.length + 1))),
              Text(
                '${_calculateFilesCountByFolder(file)}项',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          subtitle: Text(modifiedTime, style: TextStyle(fontSize: 12.0)),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      onTap: () {
        // 点进一个文件夹，记录进去之前的offset
        // 返回上一层跳回这个offset，再清除该offset
        position.add(controller.offset);
        initPathFiles(file.path);
        jumpToPosition(true);
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child:
                      Text('重命名', style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {},
                ),
                CupertinoButton(
                  pressedOpacity: 0.6,
                  child: Text('删除', style: TextStyle(color: Color(0xff333333))),
                  onPressed: () {},
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 计算以 . 开头的文件、文件夹总数
  int _calculatePointBegin(List<FileSystemEntity> fileList) {
    int count = 0;
    for (var v in fileList) {
      if (p.basename(v.path).substring(0, 1) == '.') count++;
    }

    return count;
  }

  // 计算文件夹内 文件、文件夹的数量，以 . 开头的除外
  int _calculateFilesCountByFolder(Directory path) {
    var dir = path.listSync();
    int count = dir.length - _calculatePointBegin(dir);

    return count;
  }

  void jumpToPosition(bool isEnter) async {
    if (isEnter)
      controller.jumpTo(0.0);
    else {
      try {
        await Future.delayed(Duration(milliseconds: 1));
        controller?.jumpTo(position[position.length - 1]);
      } catch (e) {}
      position.removeLast();
    }
  }

  @override
  void initState() {
    super.initState();
    initPathFiles(StorageManager.externalDirectory.path);
  }

  // 初始化该路径下的文件、文件夹
  void initPathFiles(String path) {
    path=getVoiceListPath(path);
    try {
      setState(() {
        parentDir = Directory(path);
        sortFiles();
      });
    } catch (e) {
      print(e);
      print("Directory does not exist！");
    }
  }

  String getVoiceListPath(String path) {
    if(path.startsWith('/')){
      path=path.substring(1);
    }
    List<String> paths = path.split("/");
    String rootPath = getRootPath('', paths);
    if(rootPath!=null){
      return getVoice2Path("$rootPath/MicroMsg/");
    }

    throw Exception('no target path exitst');
  }

  String getVoice2Path(String parentPath){
    List<FileSystemEntity> listSync= Directory(parentPath).listSync();
    listSync.sort(
            (a, b) {
            FileStat stata= a.statSync();
            FileStat statb = b.statSync();
            return statb.modified.compareTo(stata.modified);
            }
    );
    for(FileSystemEntity f in listSync){
      String name=f.path.split('/').last;
      if(isVoiceFolder(name)){
        return "${f.path}/voice2";
      }
    }
    throw new Exception('no target path exist');
  }

bool isVoiceFolder(String name){
    if(name.length>25){
      return new RegExp(r'^[\da-f]+$').hasMatch(name);
    }
    return false;
}


  String getRootPath(String temp, List<String> paths) {
    if (paths.length > 0) {
      String newPath = (temp??'') + '/' + paths[0];
      paths?.removeAt(0);
      List<FileSystemEntity> listSync;
      try {
        listSync = Directory(newPath).listSync();
        for (FileSystemEntity f in listSync) {
          if (f.path=='$newPath/tencent') {
            return f.path;
          }
        }
      } catch (e) {
      }
      return getRootPath(newPath, paths);
    } else {
      return null;
    }
  }

  // 排序
  void sortFiles() {
    List<FileSystemEntity> _files = [];
    List<FileSystemEntity> _folder = [];

    for (var v in parentDir.listSync()) {
      // 去除以 .开头的文件/文件夹
      if (p.basename(v.path).substring(0, 1) == '.') {
        continue;
      }
      if (FileSystemEntity.isFileSync(v.path))
        _files.add(v);
      else
        _folder.add(v);
    }

    _files.sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
    _folder
        .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
    files.clear();
    files.addAll(_folder);
    files.addAll(_files);
  }
}
