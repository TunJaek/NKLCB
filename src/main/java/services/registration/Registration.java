package services.registration;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import beans.ActionBean;
import beans.GoSuBean;
import beans.GroupBean;

/* Registration Class
 * - 대표자등록 memberJoinCtl
 * - 상점등록 regStoreCtl
 * - 직원등록 regEmpCtl
 * - 분류등록 regCategoriesCtl
 * */

public class Registration {
	private HttpServletRequest req;
	private RegDataAccessObject dao;

	public Registration(HttpServletRequest req) {
		this.req = req;
	}

	public ActionBean backController(int serviceCode) {

		ActionBean action = null;
		switch (serviceCode) {
		case 1:
			action = this.JoinCtl();
			break;
		case 2:
			action = this.GosuJoinCtl();
			break;
		}
		return action;
	}

	/* 그룹네임 중복 체크 */
	private ActionBean JoinCtl() {
		GroupBean group = new GroupBean();
		Boolean forward = false, tran = false;
		ActionBean action = new ActionBean();
		String message = null, page = "group-step1.jsp";

		// 아이디가 DB에 없다면,
		group.setGroupCode(this.req.getParameter("ID"));
		group.setGroupPin(this.req.getParameter("Password"));
		group.setGroupPhn(this.req.getParameter("PhoneNumber"));
		group.setGroupLank("L1");

		this.dao = new RegDataAccessObject();
		Connection connection = this.dao.openConnection();

		dao.modifyTranStatus(connection, false);
		if (!this.convertToBoolean(dao.groupId(connection, group))) {
			if (tran = (this.convertToBoolean(dao.groupPhn(connection, group)))) {
				message = "중복된 번호 : 이미 사용중인 휴대폰 번호 입니다.";
				forward = false;
			} else {
				this.dao.insLogIn(connection, group);
				page = "index.jsp";
				forward = true;
				/* Dynamic Data(DB Data) >> Request */
				message = "회원가입이 완료되었습니다.";
			}
		} else {
			message = "중복된 아이디 : 이미 사용중인 아이디 입니다.";
			forward = false;
		}

		dao.setTransaction(true, connection);
		dao.modifyTranStatus(connection, true);// 자동커밋
		dao.closeConnection(connection);
		this.dao = null;

		if (message != null) {
			try {
				page += "?message=" + URLEncoder.encode(message, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		action.setPage(page);
		action.setRedirect(forward);

		return action;
	}

	private ActionBean GosuJoinCtl() {
		GroupBean group = new GroupBean();
		Boolean forward = false, tran = true;
		ActionBean action = new ActionBean();
		String message = null, page = "group-step1.jsp";
		// 아이디가 DB에 없다면,
		group.setGroupCode(this.req.getParameter("ID"));
		group.setGroupPin(this.req.getParameter("Password"));
		group.setGroupPhn(this.req.getParameter("PhoneNumber"));
		group.getGosuList().get(0).setJob(this.req.getParameter("Job"));
		group.getGosuList().get(0).setSex(this.req.getParameter("Sex"));
		group.setGroupLank("L2");

		this.dao = new RegDataAccessObject();
		Connection connection = this.dao.openConnection();

		dao.modifyTranStatus(connection, false);
		if (!this.convertToBoolean(dao.groupId(connection, group))) {
			if (!this.convertToBoolean(dao.groupPhn(connection, group))) {
				message = "중복된 번호 : 이미 사용중인 휴대폰 번호 입니다.";
				forward = false;
			} else {
				if (this.convertToBoolean(this.dao.insLogIn(connection, group))) {
					if (this.convertToBoolean(this.dao.insGoSu(connection, group))) {
						// 고수테이블까지 ins완료
					}
				}
				page = "mainMenu.jsp";
				forward = true;
				message = "회원가입이 완료되었습니다.";
			}
		} else {
			message = "중복된 아이디 : 이미 사용중인 아이디 입니다.";
			forward = false;
		}
				 
		dao.setTransaction(true, connection);
		dao.modifyTranStatus(connection, true);// 자동커밋
		dao.closeConnection(connection);
		this.dao = null;

		if (message != null) {
			try {
				page += "?message=" + URLEncoder.encode(message, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		action.setPage(page);
		action.setRedirect(forward);
		return action;
	}

	/* Convert to Boolean */
	private boolean convertToBoolean(int value) {
		return value > 0 ? true : false;
	}

}
