class Api{
  static const String BaseUrl = "http://shencangblue.com/";
  static const String BaseUrl_com = "http://shencangblue.com";

  //用户相关方法
  static const String LoginEmail = "loginE/";
  static const String Login = "login/";
  static const String Register = "register/";
  static const String GetUserInfo  = "getUserInfo/";
  static const String FindEmailRepeat = "findEmailRepeat/";
  static const String UpdatePassword = "updatePassword/";
  static const String UpdateUser = "updateUser/";


  // 项目的相关方法
  static const String DeleteProject = "deleteProject/";
  static const String AddProject = "addProject/";
  static const String FindProject =  "findProject/";



  // 任务的相关方法
  static const String DeleteTask = "deleteTask/";
  static const String AddTask  = "addTask/";
  static const String UpdateStatus = "updateTaskStatus/";
  static const String UpdateTask = "updateTask/";
  static const String FindTask = "findTask/";
  static const String GetTaskByProject = "getTaskByProject/";
  static const String GetTaskByLabel = "getTaskByLabel/";




  // 标签的相关方法
  static const String AddLabel = "addLabel/";
  static const String FindLabel = "findLabel/";

  //关系表的相关方法
  static const String AddRelation = "addRelation/";
  static const String FindTaskLabel = "findTaskLabel/";
  static const String FindLabelTask = "findLabelTask/";



}