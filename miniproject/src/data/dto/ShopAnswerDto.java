package data.dto;

import java.sql.Timestamp;

public class ShopAnswerDto {
	private String idx;
	private String shopnum;
	private String myid;
	private String content;
	private String shopanswer;
	private Timestamp writeday;
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getShopnum() {
		return shopnum;
	}
	public void setShopnum(String shopnum) {
		this.shopnum = shopnum;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getShopanswer() {
		return shopanswer;
	}
	public void setShopanswer(String shopanswer) {
		this.shopanswer = shopanswer;
	}
	public Timestamp getWriteday() {
		return writeday;
	}
	public void setWriteday(Timestamp writeday) {
		this.writeday = writeday;
	}
	
	
}
