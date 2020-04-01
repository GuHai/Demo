package com.yskj.models;

import lombok.Data;

import java.util.List;

@Data
public class MonthVoucher {
    private String tempMonth ;
    private List<Voucher> voucherList ;
}
