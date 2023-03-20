package beans;

import java.util.ArrayList;

public class GoSuBean {

private String Job;
private String Sex;
private ArrayList<AccessLogBean> AccessList;

public ArrayList<AccessLogBean> getAccessList() {
	return AccessList;
}
public void setAccessList(ArrayList<AccessLogBean> accessList) {
	AccessList = accessList;
}
public String getJob() {
	return Job;
}
public void setJob(String job) {
	Job = job;
}
public String getSex() {
	return Sex;
}
public void setSex(String sex) {
	Sex = sex;
}
	
}
