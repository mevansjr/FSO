package com.markevansjr.sqlite;

public class Vehicle {
	private long id;
	private String call;
	private String tag;
	private String vin;
	private String property;
	private String serial;
	private String installdate;
	private String parseid;
	private String datemod;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getCall() {
		return call;
	}
	public void setCall(String call) {
		this.call = call;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getVin() {
		return vin;
	}
	public void setVin(String vin) {
		this.vin = vin;
	}
	public String getProperty() {
		return property;
	}
	public void setProperty(String property) {
		this.property = property;
	}
	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	public String getInstalldate() {
		return installdate;
	}
	public void setInstalldate(String installdate) {
		this.installdate = installdate;
	}
	public String getParseid() {
		return parseid;
	}
	public void setParseid(String parseid) {
		this.parseid = parseid;
	}
	public String getDatemod() {
		return datemod;
	}
	public void setDatemod(String datemod) {
		this.datemod = datemod;
	}
	@Override
	public String toString() {
		return call + "\n" + vin;
	}
}
