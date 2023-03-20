package services.auth;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.AccessLogBean;
import beans.GroupBean;
import services.DataAccessObject;

public class AuthDataAccessObject extends DataAccessObject {
	AuthDataAccessObject() {
	}

	final Connection openConnection() {
		return this.openConnect();
	}

	final Connection openConnection(String userName, String password) {
		return this.openConnect();
	}

	final void closeConnection(Connection connect) {
		this.closeConnect(connect);
	}

	final void modifyTranStatus(Connection connect, boolean tran) {
		this.setTranStatus(connect, tran);
	}

	final void setTransaction(boolean tran, Connection connect) {
		this.setTransactionEnd(tran, connect);
	}

	final int isId(Connection connect, GroupBean group) {
		int result = 0;

		String query = "SELECT COUNT(*) AS ISID FROM DBAHHJT.CM " + "WHERE CM_ID = ?";
		try {
			this.ps = connect.prepareStatement(query);
			this.ps.setNString(1, group.getGroupCode());

			if ((this.rs = this.ps.executeQuery()).isBeforeFirst()) {
				this.rs.next();
				result = this.rs.getInt("ISID");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	final int isPinCode(Connection connect, GroupBean group) {
		int result = 0;
		String query = "SELECT COUNT(*) AS ISACCESS FROM DBAHHJT.CM " + "WHERE CM_PINCODE=? AND CM_ID=?";
		try {
			this.ps = connect.prepareStatement(query);
			this.ps.setNString(1, group.getGroupPin());
			this.ps.setNString(2, group.getGroupCode());
			this.rs = this.ps.executeQuery();

			if ((this.rs = this.ps.executeQuery()).isBeforeFirst()) {
				this.rs.next();
				result = this.rs.getInt("ISACCESS");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	final int insAccessLog(Connection connect, GroupBean group) {
		int result = 0;
		String dml = "INSERT INTO DBAHHJT.AL(AL_CMID, AL_DATE, AL_IP, AL_TYPE) " + "VALUES (? , DEFAULT , ? ,? ) ";
		try {
			this.ps = connect.prepareStatement(dml);
			this.ps.setNString(1, group.getGroupCode());
			this.ps.setNString(2, group.getGosuList().get(0).getAccessList().get(0).getAccessPublicIp());
			this.ps.setInt(3, group.getGosuList().get(0).getAccessList().get(0).getAccessType());

			result = this.ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;

	}

	int isAccess(Connection connect, GroupBean group, boolean isSession) {
		int result = 0;
		String query = "SELECT COUNT(*) ISACCESS " + "FROM DBAHHJT.ISACCESS "
				+ "WHERE AL_ID =? AND AL_ISACCESS = ? AND AL_IP =?_";
		try {
			this.ps = connect.prepareStatement(query);
			this.ps.setNString(1, group.getGroupCode());
			this.ps.setInt(2, group.getGosuList().get(0).getAccessList().get(0).getAccessType());
			this.ps.setNString(3, group.getGosuList().get(0).getAccessList().get(0).getAccessPublicIp());
			;
			this.rs = this.ps.executeQuery();
			while (this.rs.next()) {
				result = this.rs.getInt("ISACCESS");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
