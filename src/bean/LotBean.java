package bean;

public class LotBean {
    private int numb;
    private String name;
    private String pswd;
    private int pric;
    private int perh;
    private int perd;
    private int free;

    public int getNumb() { return numb; };
    public String getName() { return name; };
    public String getPswd() { return pswd; };
    public int getPric() { return pric; };
    public int getPerh() { return perh; };
    public int getPerd() { return perd; };
    public int getFree() { return free; };
    
    public void setNumb(int numb) { this.numb = numb; }
	public void setName(String name) { this.name = name; }
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	public void setPric(int pric) {
		this.pric = pric;
	}
	public void setPerh(int perh) {
		this.perh = perh;
	}
	public void setPerd(int perd) {
		this.perd = perd;
	}
	public void setFree(int free) {
		this.free = free;
	}
}