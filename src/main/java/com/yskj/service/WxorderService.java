package com.yskj.service;import com.google.gson.Gson;import com.yskj.dao.AccountDao;import com.yskj.dao.WxorderDao;import com.yskj.exception.IJobException;import com.yskj.models.Account;import com.yskj.models.QueryParam;import com.yskj.models.Wxorder;import com.yskj.service.base.AbstractService;import com.yskj.utils.DateUtils;import com.yskj.utils.SignUtils;import com.yskj.utils.StringUtils;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import java.math.BigDecimal;import java.util.HashMap;import java.util.List;import java.util.Map;@Servicepublic class WxorderService extends AbstractService {	@Autowired    private WxorderDao wxorderDao;	@Autowired	private AccountDao accountDao;	public WxorderService() {		super();	}	@Override	public WxorderDao getDao() {		return this.wxorderDao;	}	public String getNextCode(String type){		return getCodeTitle(type)+DateUtils.getCurrTime()+ SignUtils.getRandomStringByLength(17);	}	private String getFullNo(Long num){		String str = "000000000"+num;		return str.substring(str.length()-10,str.length());	}	private   String getCodeTitle(String type ){		if(Wxorder.Bond.equals(type)){			return "B";		}else if(Wxorder.Settle.equals(type)){			return "S";		}else if(Wxorder.Partner.equals(type)){			return "P";		}else if(Wxorder.RedPacket.equals(type)){			return "R";		}else if(Wxorder.ScanSettle.equals(type)){ //二维码扫描结算			return "Q";		}else if(Wxorder.Indemnity.equals(type)){ //二维码扫描结算			return "I";		}else if(Wxorder.Postage.equals(type)){ //二维码扫描结算			return "O";		}		return "Z";	}	public   String getTypeName(String type ){		if(Wxorder.Bond.equals(type)){			return "保证金";		}else if (Wxorder.Settle.equals(type)){			return "薪资结算";		}else if( Wxorder.Partner.equals(type)){			return "合伙人入伙费";		}else if( Wxorder.RedPacket.equals(type)){			return "分享红包";		}else if( Wxorder.ScanSettle.equals(type)){			return "二维码扫码结算";		}else if( Wxorder.Indemnity.equals(type)){			return "保证金先违约后赔付";		}else if( Wxorder.Postage.equals(type)){			return "邮费支付";		}		return "未知类型";	}	public String getNotice(String type){		if(Wxorder.Bond.equals(type)){			return "保证金在完成工作之后会退回到您的余额";		}else if (Wxorder.Settle.equals(type)){			return "";		}else if( Wxorder.Partner.equals(type)){			return "";		}else if( Wxorder.RedPacket.equals(type)){			return "红包若是没被领取完，剩余的红包将会退回到您的余额";		}		return "";	}	public Long update(Wxorder wxorder)throws Exception{		if(wxorder.getStatus()==4&&wxorder.getPayType()!=null&&wxorder.getPayType()==2){ //如果是执行回调，并且是余额支付，则需要计算余额支付的md5			QueryParam queryParam = new QueryParam();			queryParam.put("type",Account.YU_E_PAY);			queryParam.put("orderNo",wxorder.getCode());			queryParam.put("userID",wxorder.getUserID());			queryParam.put("notExtract",Boolean.TRUE);			Account account  =accountDao.one(queryParam);			if(account!=null){				queryParam.clear();				queryParam.put("userID",wxorder.getUserID());				queryParam.put("isIn",Boolean.TRUE);				queryParam.put("isPass",Boolean.TRUE);				queryParam.put("hasExtract",Boolean.TRUE);				queryParam.setOrderByClause(" order by a.type desc  "); //先从充值开始支付				List<Account> accounts = accountDao.findList(queryParam);				BigDecimal withmoney  = new BigDecimal(wxorder.getFee()).divide(new BigDecimal(100)).setScale(2,BigDecimal.ROUND_HALF_UP);				String accID="";				for(Account a :  accounts){					if(a.getIsCheck()==null||a.getIsCheck()==Boolean.FALSE){  //未检查，或者检查为空						continue;					}					if(withmoney.compareTo(BigDecimal.ZERO)>0){						Map json = StringUtils.isEmpty(a.getAccID())?new HashMap():new Gson().fromJson(a.getAccID(),HashMap.class);						BigDecimal extract = a.getExtract()==null?BigDecimal.ZERO:a.getExtract(); //当前提取金额						BigDecimal extractaSurplus = a.getMoney().subtract(extract);  //剩余提取金额						BigDecimal extractable = withmoney.min(extractaSurplus);      //这个单的可以提取金额						withmoney = withmoney.subtract(extractable);  //提现剩余金额						BigDecimal extracted = extract.add(extractable);   //提现后提取金额						accID += a.getId()+",";						json.put(account.getId(),extractable);						a.setExtract(extracted);						a.setAccID(new Gson().toJson(json));						a.setVersion(a.getVersion()+1);						a.setUpdateTime(account.getUpdateTime());						accountDao.update(a);					}else{						break;					}				}				if(withmoney.compareTo(BigDecimal.ZERO)>0){ //如果是空，则提示余额不足 如果是余额还没扣完，则是余额不足					throw new IJobException("余额不足");				}else{					account.setAccID(accID);					account.setVersion(account.getVersion()+1);					accountDao.update(account);				}			}		}		return super.update(wxorder);	}	public void clearGarbageOrder(){		this.getDao().clearGarbageOrder();	}}