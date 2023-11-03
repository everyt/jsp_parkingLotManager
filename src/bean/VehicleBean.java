package bean;

public class VehicleBean {
	private int numb;
	private boolean regi; //차량이 등록된 회원인지
	private boolean dayp; //차량이 일정액을 사용하는지
	private boolean stat; //차량이 주차중인지
	private String cnum;
	private String type;
	private int plot;
	private int deta;
	public int getNumb() {
		return numb;
	}
	public boolean getRegi() {
		return regi;
	}
	public boolean getDayp() {
		return dayp;
	}
	public boolean getStat() {
		return stat;
	}
	public String getCnum() {
		return cnum;
	}
	public String getType() {
		return type;
	}
	public int getPlot() {
		return plot;
	}
	public int getDeta() {
		return deta;
	}
	public void setNumb(int numb) {
		this.numb = numb;
	}
	public void setRegi(boolean regi) {
		this.regi = regi;
	}
	public void setDayp(boolean dayp) {
		this.dayp = dayp;
	}
	public void setStat(boolean stat) {
		this.stat = stat;
	}
	public void setCnum(String cnum) {
		this.cnum = cnum;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setPlot(int plot) {
		this.plot = plot;
	}
	public void setDeta(int deta) {
		this.deta = deta;
	}

}
