package services.auth;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import beans.AccessLogBean;
import beans.ActionBean;
import beans.GoSuBean;
import beans.GroupBean;

/* Auth Class
 * - 로그인
 * - 로그아웃
 * - 암호화 
 * */
public class Auth {
	private HttpServletRequest req;
	private AuthDataAccessObject dao;
	private Connection connect;
	private HttpSession session;

	public Auth(HttpServletRequest req) {
		this.req = req;
		this.session = this.req.getSession();
		this.session.setMaxInactiveInterval(60);
	}

	public ActionBean backController(int serviceCode) {
		ActionBean action = null;
		switch (serviceCode) {
		case 0:
			action = this.accessCtl();
			break;
		case -1:
			action = this.accessOutCtl();
			break;

		}

		return action;
	}

	private ActionBean accessCtl() {
		/* Job Controller Pattern */
		ActionBean action = new ActionBean();
		GroupBean group = new GroupBean();
		String page = "group-step1.jsp", message = "";
		boolean isForward = false, tran = false;
		
		System.out.println(this.req.getParameter("ID"));
		System.out.println(this.req.getParameter("Password"));

		/* 1. Client Data : */
		ArrayList<GroupBean> groupList = new ArrayList<GroupBean>();
		ArrayList<AccessLogBean> accessList = new ArrayList<AccessLogBean>();
		AccessLogBean access = new AccessLogBean();
		
		if (session.getAttribute("AccessInfo") == null) {
			
			access.setAccessPublicIp(this.req.getRemoteAddr());
			access.setAccessType(1);
			accessList.add(access);
			
			GoSuBean goSu= new GoSuBean();
			ArrayList<GoSuBean> gosuList = new ArrayList<GoSuBean>();
			goSu.setAccessList(accessList);
			gosuList.add(goSu);
			
			group.setGosuList(gosuList);
			group.setGroupCode(this.req.getParameter("ID"));
			group.setGroupPin(this.req.getParameter("Password"));
		

			/* Browser 정보 */

			/* 2. DAO */
			this.dao = new AuthDataAccessObject();
			this.connect = this.dao.openConnection();
			this.dao.modifyTranStatus(connect, tran);

			if (!this.convertToBoolean(this.dao.isId(this.connect, group))) {
				message = "아이디를 다시 입력해 주세요.";
				page = "index.jsp";
			} else {
				if (!this.convertToBoolean(this.dao.isPinCode(this.connect, group))) {
					message = "비밀번호를 다시 입력해 주세요.";
					page = "index.jsp";
				} else {
					if (this.convertToBoolean(this.dao.insAccessLog(this.connect, group))) {
						page = "mainMenu.jsp";
						message = "로그인 성공!";
					
						session.setAttribute("AccessInfo", group);
					}
				}

			}
		}

		this.dao.setTransaction(true, connect);
		this.dao.modifyTranStatus(connect, true);
		this.dao.closeConnection(connect);

		if (message != null) {
			try {
				page += "?message=" + URLEncoder.encode(message, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}

		action.setPage(page);
		action.setRedirect(isForward);
		return action;
	}

	private boolean convertToBoolean(int value) {
		return (value > 0) ? true : false;
	}

	private ActionBean accessOutCtl(GroupBean... group) {
		/* Job Controller Pattern */
		GroupBean groupB = new GroupBean();
		ActionBean action = new ActionBean();
		String page = "index.jsp", message = "";
		boolean isForward = false;
		AccessLogBean accessOut = new AccessLogBean();
		/* DAO */
		if (this.dao == null) {
			this.dao = new AuthDataAccessObject();
			this.connect = this.dao.openConnection();
			this.dao.modifyTranStatus(connect, false);

			if ((GroupBean) this.session.getAttribute("AccessInfo") != null) {
				accessOut = ((GroupBean) this.session.getAttribute("AccessInfo")).getGosuList().get(0).getAccessList()
						.get(0);
				accessOut.setAccessType(-1);
				if (!this.convertToBoolean(this.dao.insAccessLog(this.connect, groupB))) {
					if (this.convertToBoolean(this.dao.isId(this.connect, groupB))) {
						if (this.convertToBoolean(this.dao.isPinCode(this.connect, groupB))) {
							if (this.convertToBoolean(this.dao.insAccessLog(this.connect, groupB))) {
								message = "로그아웃 완료";
							}
						}
					}
					this.dao.setTransaction(true, connect);
					this.dao.modifyTranStatus(connect, true);
					this.dao.closeConnection(connect);
				}
				if (message != null) {
					try {
						page += "?message=" + URLEncoder.encode(message, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}

			}
			action.setPage(page);
			action.setRedirect(isForward);
		}
		return action;

	}

	boolean isAccess(GroupBean group, Boolean isSession) {
		boolean isAccess = false, isDao = this.dao != null ? true : false;

		if (!isDao) {
			this.dao = new AuthDataAccessObject();
			this.connect = this.dao.openConnection();

			isAccess = this.convertToBoolean(this.dao.isAccess(connect, group, isSession));

			this.dao.closeConnection(connect);
			this.dao = null;
		} else {
			isAccess = this.convertToBoolean(this.dao.isAccess(connect, group, isSession));
		}

		return isAccess;
	}

}