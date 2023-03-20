package beans;

import java.util.ArrayList;

public class GroupBean {
	private String groupCode;
	private String groupPin;
	private String groupPhn;
	private String groupLank;
	private ArrayList<GoSuBean> gosuList;


	public ArrayList<GoSuBean> getGosuList() {
		return gosuList;
	}
	public void setGosuList(ArrayList<GoSuBean> gosuList) {
		this.gosuList = gosuList;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public String getGroupPin() {
		return groupPin;
	}
	public void setGroupPin(String groupPin) {
		this.groupPin = groupPin;
	}
	public String getGroupPhn() {
		return groupPhn;
	}
	public void setGroupPhn(String groupPhn) {
		this.groupPhn = groupPhn;
	}
	public String getGroupLank() {
		return groupLank;
	}
	public void setGroupLank(String groupLank) {
		this.groupLank = groupLank;
	}
}

