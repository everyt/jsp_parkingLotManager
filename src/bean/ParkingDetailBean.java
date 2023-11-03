package bean;

import java.sql.Timestamp;

public class ParkingDetailBean {
	private int numb;
	private int veid;
	private Timestamp ente;
	private Timestamp leav;
	private int plot;
	  
	public int getNumb() {
		return numb;
	}
	public int getVeid() {
		return veid;
	}
	public Timestamp getEnte() {
		return ente;
	}
	public Timestamp getLeav() {
		return leav;
	}
	public int getPlot() {
		return plot;
	}
	public void setNumb(int numb) {
		this.numb = numb;
	}
	public void setVeid(int veid) {
		this.veid = veid;
	}
	public void setEnte(Timestamp ente) {
		this.ente = ente;
	}
	public void setLeav(Timestamp leav) {
		this.leav = leav;
	}
	public void setPlot(int plot) {
		this.plot = plot;
	}

}
