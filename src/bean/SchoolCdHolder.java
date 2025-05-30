package bean;

import java.io.Serializable;

public class SchoolCdHolder implements Serializable {
    private String schoolCd;

    public SchoolCdHolder() {}

    public String getSchoolCd() {
        return schoolCd;
    }

    public void setSchoolCd(String schoolCd) {
        this.schoolCd = schoolCd;
    }
}