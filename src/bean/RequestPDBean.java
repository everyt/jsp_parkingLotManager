package bean;

public class RequestPDBean {
	private String cnum;
	private String type;
	private boolean regi; //차량이 등록된 회원인지
	private boolean dayp; //차량이 일정액을 사용하는지
	private boolean ente;
	private int plot;
	
	public String getCnum() {
		return cnum;
	}
	public String getType() {
		return type;
	}
	public boolean getRegi() {
		return regi;
	}
	public boolean getDayp() {
		return dayp;
	}
	public boolean getEnte() {
		return ente;
	}
	public int getPlot() {
		return plot;
	}
	public void setCnum(String cnum) {
		this.cnum = cnum;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setRegi(boolean regi) {
		this.regi = regi;
	}
	public void setDayp(boolean dayp) {
		this.dayp = dayp;
	}
	public void setEnte(boolean ente) {
		this.ente = ente;
	}
	public void setPlot(int plot) {
		this.plot = plot;
	}

}
