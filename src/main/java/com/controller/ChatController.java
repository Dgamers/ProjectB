package com.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import com.alibaba.fastjson.JSON;
import com.pojo.ChatRecord;
import com.pojo.ChatRoom;
import com.pojo.User;
import com.service.ChatRecordService;
import com.service.ChatRoomService;
import com.service.UserService;
import com.utils.ChatRecordResult;
import com.websocket.MyHandler;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
   private  MyHandler handler;
    
    @Autowired
    private ChatRoomService chatRoomService;
    
    @Autowired
    private ChatRecordService chatRecordService;
    
    @Autowired
    private UserService userService;

    @RequestMapping(value="/sendmessage",produces="text/html;charset=UTF-8;")
    @ResponseBody
    public  String sendMessage(Integer toid,HttpSession session,String content)throws Exception {
    	content  = new String(content.getBytes("ISO8859-1"), "UTF-8");
     	User user=(User) session.getAttribute("user");
    	Integer fromid=user.getId();
    	String joiner=fromid<toid?"/"+fromid+"/"+toid+"/":"/"+toid+"/"+fromid+"/";
    	ChatRoom chatRoom=chatRoomService.selectbyjoiner(joiner);
    	if(chatRoom==null) {
    		chatRoom=new ChatRoom();
    		chatRoom.setCreatetime(new Date());
    		chatRoom.setUpdatetime(new Date());
    		chatRoom.setStatus(1);
    		chatRoom.setJoiner(joiner);
    		chatRoomService.insert(chatRoom);
    	}else {
    		chatRoomService.updateupdatetime(chatRoom.getId(), new Date());
    	}
    	ChatRecord chatRecord=new ChatRecord();
    	chatRecord.setChatroom(chatRoom.getId());
    	chatRecord.setRecord(content);
    	chatRecord.setSender(fromid);
    	chatRecord.setCreatetime(new Date());
    	chatRecordService.insert(chatRecord);
        boolean hasSend = handler.sendMessageToUser(toid, new TextMessage(content));
        System.out.println(hasSend);
        return content;
    }
    
    @RequestMapping("/initchat")
    public String initchat(Model model,HttpSession session) {
    	User user=(User) session.getAttribute("user");
    	List<User>userlist=null;
    	List<ChatRoom>roomlist=chatRoomService.selectbyuserid(user.getId());
    	if(roomlist!=null) {
    		List<Integer>joinerlist=getuserid(roomlist,user.getId());
    		
    		if(joinerlist.size()!=0) {
    			userlist=userService.selectByjoiner(joinerlist);
    			model.addAttribute("choose", userlist.get(0).getId());
    		}else {
    			userlist=null;
    		}
    		
    	}
    	model.addAttribute("userlist", userlist);
    	return "chat";
    }
    
	@RequestMapping("/addchatuser")
	public String addchatuser(Integer id,Model model,HttpSession session) {
		User user=(User) session.getAttribute("user");
		Integer fromid=user.getId();
    	String joiner=fromid<id?"/"+fromid+"/"+id+"/":"/"+id+"/"+fromid+"/";
    	ChatRoom chatRoom=chatRoomService.selectbyjoiner(joiner);
    	if(chatRoom==null) {
    		User adduser=userService.selectByPrimaryKey(id);
    		model.addAttribute("adduser", adduser);
    	}else {
    		model.addAttribute("choose", id);
    	}
		List<ChatRoom>roomlist=chatRoomService.selectbyuserid(user.getId());
		List<Integer>joinerlist=getuserid(roomlist,user.getId());
		List<User>userlist;
		if(joinerlist.size()!=0) {
			userlist=userService.selectByjoiner(joinerlist);
		}else {
			userlist=null;
		}
		model.addAttribute("userlist", userlist);
		return "chat";
	}
	
	@RequestMapping(value="/getchatrecord",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getchatrecord(Integer chooseuserid,HttpSession session) {
		User user=(User) session.getAttribute("user");
		Integer fromid=user.getId();
    	String joiner=fromid<chooseuserid?"/"+fromid+"/"+chooseuserid+"/":"/"+chooseuserid+"/"+fromid+"/";
    	ChatRoom chatRoom=chatRoomService.selectbyjoiner(joiner);
    	List<ChatRecord>list=chatRecordService.selectByRoomid(chatRoom.getId());
    	User chooseuser=userService.selectByPrimaryKey(chooseuserid);
    	ChatRecordResult result=new ChatRecordResult();
    	result.setChatRecords(list);
    	result.setChooseuser(chooseuser);
    	return JSON.toJSONString(result);
	}
	
	@RequestMapping(value="/deleteuser",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String deleteuser(Integer chooseuserid,HttpSession session) {
		User user=(User) session.getAttribute("user");
		Integer fromid=user.getId();
    	String joiner=fromid<chooseuserid?"/"+fromid+"/"+chooseuserid+"/":"/"+chooseuserid+"/"+fromid+"/";
    	ChatRoom chatRoom=chatRoomService.selectbyjoiner(joiner);
        chatRoomService.updatestatus(chatRoom.getId(), 0);
		List<ChatRoom>roomlist=chatRoomService.selectbyuserid(user.getId());
		List<Integer>joinerlist=getuserid(roomlist,user.getId());
		List<User>userlist;
		if(joinerlist.size()!=0) {
			userlist=userService.selectByjoiner(joinerlist);
		}else {
			userlist=null;
		}

    	return JSON.toJSONString(userlist);
	}
	
	public List<Integer>getuserid(List<ChatRoom>roomlist,Integer currentuserid){
		List<Integer>useridlist=new ArrayList<>();
		String [] temp;
		for (ChatRoom chatRoom : roomlist) {
			temp=chatRoom.getJoiner().substring(1).split("/");
			for (String tempid : temp) {
				if(tempid!=null&&!tempid.isEmpty()&&!tempid.equals(currentuserid.toString())) 
					useridlist.add(Integer.parseInt(tempid));
			}
		}
		return useridlist;
	}

	
}
