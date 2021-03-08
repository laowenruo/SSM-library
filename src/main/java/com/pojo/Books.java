package com.pojo;

/*使用lombok插件！*/
import com.util.DateUtils;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Books {

    private int bookID;
    private String bookName;
    private int bookCounts;
    private String detail;

    public int getBookID() {  //这里不知道为什么我的IDEA会报红BookMapper.xml的方法，所以手动专门实现了这个
        return bookID;
    }
}