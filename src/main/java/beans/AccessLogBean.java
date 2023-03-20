package beans;

public class AccessLogBean {
	private String accessDateTime;
	private int accessType;
	private String accessPublicIp;
	
	
	public String getAccessPublicIp() {
		return accessPublicIp;
	}
	public void setAccessPublicIp(String accessPublicIp) {
		this.accessPublicIp = accessPublicIp;
	}
	public String getAccessDateTime() {
		return accessDateTime;
	}
	public void setAccessDateTime(String accessDateTime) {
		this.accessDateTime = accessDateTime;
	}
	public int getAccessType() {
		return accessType;
	}
	public void setAccessType(int accessType) {
		this.accessType = accessType;
	}

	
	
	
}