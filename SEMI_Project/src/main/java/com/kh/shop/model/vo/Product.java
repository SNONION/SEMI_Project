package com.kh.shop.model.vo;

public class Product {
    
    private int proNo;
	private int shopFileNo;
	private String proName;
	private String proMenual; 
	private int price;
	private String status;
	
	private int boardNo;
	private int quantity;
	
	// 파일을 저장해줄 변수
	private String proPath;
	private String proImgName;
	
	public Product() {
		super();
	}

	public Product(int proNo, int shopFileNo, String proName, String proMenual, int price, String status) {
		super();
		this.proNo = proNo;
		this.shopFileNo = shopFileNo;
		this.proName = proName;
		this.proMenual = proMenual;
		this.price = price;
		this.status = status;
	}
	
	
	public Product(int proNo, int shopFileNo, String proName, String proMenual, int price) {
		super();
		this.proNo = proNo;
		this.shopFileNo = shopFileNo;
		this.proName = proName;
		this.proMenual = proMenual;
		this.price = price;
	}


	


	public Product(int proNo, String proName, String proMenual, int price, String status) {
		super();
		this.proNo = proNo;
		this.proName = proName;
		this.proMenual = proMenual;
		this.price = price;
		this.status = status;
	}

	public String getProPath() {
		return proPath;
	}

	public void setProPath(String proPath) {
		this.proPath = proPath;
	}

	public String getProImgName() {
		return proImgName;
	}

	public void setProImgName(String proImgName) {
		this.proImgName = proImgName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getProNo() {
		return proNo;
	}

	public void setProNo(int proNo) {
		this.proNo = proNo;
	}

	public int getShopFileNo() {
		return shopFileNo;
	}

	public void setShopFileNo(int shopFileNo) {
		this.shopFileNo = shopFileNo;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getProMenual() {
		return proMenual;
	}

	public void setProMenual(String proMenual) {
		this.proMenual = proMenual;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Product [proNo=" + proNo + ", shopFileNo=" + shopFileNo + ", proName=" + proName + ", proMenual="
				+ proMenual + ", price=" + price + ", status=" + status + "]";
	}


    
}
