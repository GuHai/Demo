package general;

public class Column {
	private String columnName;
	private String name;
	private String funName;
	private String columnType;
	private String jdbcColumnType;
	private String columnClassName;
	private String type;
	private String remarks;
	private Object defaultValue;
	private int columnSize;
	private int decimalNum;
	
	public String getJdbcColumnType() {
		return jdbcColumnType;
	}
	public void setJdbcColumnType(String jdbcColumnType) {
		this.jdbcColumnType = jdbcColumnType;
	}
	public int getDecimalNum() {
		return decimalNum;
	}
	public void setDecimalNum(int decimalNum) {
		this.decimalNum = decimalNum;
	}
	public int getColumnSize() {
		return columnSize;
	}
	public void setColumnSize(int columnSize) {
		this.columnSize = columnSize;
	}
	public Object getDefaultValue() {
		return defaultValue;
	}
	public Object getDefaultValueToString(){
		if(this.defaultValue!=null){
			if(this.type.equals("Long")){
				return this.defaultValue +"L";
			}else if(this.type.equals("Double")){
				return this.defaultValue +"D";
			}else if(this.type.equals("Boolean")){
				return this.defaultValue.equals("0")?false:true;
			}else{
				return this.defaultValue.toString();
			}
		}else{
			return this.defaultValue.toString();
		}
	}
	public void setDefaultValue(Object defaultValue) {
		this.defaultValue = defaultValue;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
//		this.name = getMappedName(columnName);
		//this.funName = toUpperFirstLetterCase(this.name);\
		this.name = this.columnName = columnName;
		this.funName =  this.name.substring(0,1).toUpperCase()+this.name.substring(1);

	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getColumnType() {
		return columnType;
	}
	public void setColumnType(String columnType) {
		try {
			this.type = getMapperdType(columnType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.columnType = columnType;
	}
	
	private String getMappedName(String str){
		String mapp = "";
		//GenegralTool.createdBy+";"+GenegralTool.pkId+";"+GenegralTool.createdDate+";"+GenegralTool.modifiedBy+";"+GenegralTool.modifiedDate+";"
		if(GenegralTool.createdBy.toUpperCase().equals(str)){
			mapp  = "createdBy";
		}else if(GenegralTool.createdDate.toUpperCase().equals(str)){
			mapp  = "createdDate";
		}else if(GenegralTool.modifiedBy.toUpperCase().equals(str)){
			mapp  = "lastModifiedBy";
		}else if(GenegralTool.modifiedDate.toUpperCase().equals(str)){
			mapp  = "lastModifiedDate";
		}else{
			if(str.contains("_")){
				for(String s : str.split("_")){
					if(mapp.length()==0){
						mapp += s.toLowerCase();
					}else{
						mapp += toUpperFirstLetterCase(s);
					}
				}
			}else{
				mapp = str.toLowerCase();
			}
		}
		
		return mapp;
	}
	private String toUpperFirstLetterCase(String str){
		return  str.substring(0,1).toUpperCase()+str.substring(1).toLowerCase();
	}
	private String getMapperdType(String str)throws Exception{
		System.out.println(str);
		this.jdbcColumnType = str;
		if(str.equals("BIGINT")){
			return "Long";
		}else if(str.equals("VARCHAR")  || str.equals("TEXT")){
			/*if(this.columnSize==2){
				return "Boolean";
			}
			else*/
				return "String";
		}else if(str.equals("VARCHAR2")){
			this.jdbcColumnType = "VARCHAR";
			/*if(this.columnSize==2){
				return "Boolean";
			}
			else*/
				return "String";
		}else if(str.equals("DECIMAL")){
			return "BigDecimal";
		}else if(str.equals("BIT")){
			return "Boolean";
		}else if(str.equals("DATETIME")){
			this.jdbcColumnType = "TIMESTAMP";
			return "Date";
		}else if(str.equals("DATE")){
			return "Date";
		}else if(str.equals("LONGTEXT")){
			return "String";
		}else if(str.startsWith("TIMESTAMP")){
			this.jdbcColumnType = "TIMESTAMP";
			return "Date";
		}else if(str.startsWith("NUMBER")){
			this.jdbcColumnType = "DECIMAL";
			if(this.columnSize>0){
				return "BigDecimal";
			}else{
				if(this.decimalNum>11)
					return "Long";
				else
					return "Integer";
			}
		}else if(str.equals("CHAR")){
			if(this.columnSize==2){
				return "Char";
			}else{
				return "String";
			}
		}else if(str.equals("CLOB")){
			return "String";
		}else if(str.equals("NVARCHAR2")){
			return "String";
		}else if(str.equals("INT")){
			return "Integer";
		}else if(str.equals("DATETIME")){
			return "Date";
		}else if(str.equals("TINYINT")){
			if(this.columnSize==1){
				return "Boolean";
			}else{
				return "Integer";
			}
		}
		throw new  Exception("没有找到对应类型");
	}
	public String getColumnClassName() {
		return columnClassName;
	}
	public void setColumnClassName(String columnClassName) {
		this.columnClassName = columnClassName;
	}
	public String getFunName() {
		return funName;
	}
	public void setFunName(String funName) {
		this.funName = funName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
