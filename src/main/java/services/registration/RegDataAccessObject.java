package services.registration;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.GroupBean;


	
	public class RegDataAccessObject extends services.DataAccessObject{
	
		
		final Connection openConnection() {
			return this.openConnect();
		}
		final Connection openConnection(String userName, String password ) {
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
		public RegDataAccessObject() {}
	
	
	/* [SEL] GROUPNAME */
	final int groupId(Connection connection, GroupBean group){
		int result = 0;
		String query = "SELECT count(*) AS ISID FROM DBAHHJT.CM "
				+ "WHERE CM_ID=?";
		try {
			this.ps = connection.prepareStatement(query);
			this.ps.setNString(1, group.getGroupCode());
			
			this.rs = this.ps.executeQuery();
			
			if(this.rs.isBeforeFirst()) {
				while(this.rs.next()) {
					result = this.rs.getInt("ISID");
			
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return result;
	}
	/* [SEL] GROUPNAME */
	final int groupPhn(Connection connection, GroupBean group){
		int result = 0;
		String query = "SELECT COUNT(*) AS ISPHONE FROM DBAHHJT.CM "
				+  "WHERE CM_PHONE=?";
		try {
			this.ps = connection.prepareStatement(query);
			this.ps.setNString(1, group.getGroupPhn());
			System.out.println(group.getGroupPhn());
			
			this.rs = this.ps.executeQuery();
			
			if(this.rs.isBeforeFirst()) {
				while(this.rs.next()) {
					result = this.rs.getInt("ISPHONE");
				}
			}
		} catch (SQLException e) {e.printStackTrace();}

		return result;
	}
		
	final int insLogIn(Connection connect, GroupBean group) {
		int result = 0;
		String dml = "INSERT INTO DBAHHJT.CM(CM_ID,CM_PINCODE,CM_PHONE,CM_LANK) "
				+" VALUES (?,?,?,?)";
		try {
			this.ps = connect.prepareStatement(dml);
			this.ps.setNString(1, group.getGroupCode());
			this.ps.setNString(2, group.getGroupPin());
			this.ps.setNString(3, group.getGroupPhn());
			this.ps.setNString(4, group.getGroupLank());
		
			result = this.ps.executeUpdate();
		}catch(SQLException e) {e.printStackTrace();}
		
		return result;
	}
	final int isGoSu(Connection connect, GroupBean group) {
		int result = 0;
		String query = "SELECT GOSU "
				+ "FROM DBAHHJT.GOSU"
				+ "WHERE CM_ID =? AND CM_PHONE =? AND CW_JOB=? ";
		try {
			this.ps= connect.prepareStatement(query);
			this.ps.setNString(1, group.getGroupCode());
			this.ps.setNString(2, group.getGroupPhn());
			this.ps.setNString(3, group.getGosuList().get(0).getJob());
			
			this.rs= this.ps.executeQuery();
		}catch(SQLException e) {e.printStackTrace();}
		return result;
		
	}
	final int insGoSu(Connection  connect, GroupBean group ) {
		int result =0;
		String dml= "INSERT INTO DBAHHJT.CW (CW_CMID, CW_JOB, CW_SEX) "
				+ "VALUES (?,?,?)";
		try {
			this.ps=connect.prepareStatement(dml);
			this.ps.setNString(1,group.getGroupCode());
			this.ps.setNString(2,group.getGosuList().get(0).getJob());
			this.ps.setNString(3,group.getGosuList().get(0).getSex());
			result= this.ps.executeUpdate();
		}catch(SQLException e) {e.printStackTrace();}
		return result;
	}

}
