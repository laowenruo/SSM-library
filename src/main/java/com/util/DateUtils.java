package com.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static String parse(Date date){
        return df.format(date);
    }
}
