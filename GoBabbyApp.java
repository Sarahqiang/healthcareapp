import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

public class GoBabbyApp {
    public static void main(String[] args) throws SQLException {
        String tableName = "Midwife";
        int sqlCode = 0;      // Variable to hold SQLCODE
        String sqlState = "00000";  // Variable to hold SQLSTATE




        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        } catch (Exception cnfe) {
            System.out.println("Class not found");
        }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "ywu151";
        String your_password = "SAXJAOGWaWQv";
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if (your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if (your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection(url, your_userid, your_password);
        Statement statement = con.createStatement();


        ArrayList<String> pracid = new ArrayList<>();

        String querySQL2;

        try {
            String querySQL = "SELECT PRACTITIONERID from " + tableName + "";
            java.sql.ResultSet rs = statement.executeQuery(querySQL);
            while (rs.next()) {
                String pid = rs.getString(1);
                pracid.add(pid);
            }
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e);
        }
        while (true) {
            Scanner myObj = new Scanner(System.in);
            System.out.println("Please enter your practitioner id [E] to exit:");
            String input = myObj.nextLine();
            if (input.equals("E")) {
                System.out.println("GoodBye You are signed out!");
                con.close();
                break;
            } else if (!pracid.contains(input)) {
                System.out.println("the id is not valid");
                continue;
            } else {

                while (true) {
                    Scanner myObj2 = new Scanner(System.in);
                    System.out.println("Please enter the date for appointment list [E] to exit:");
                    String input2 = myObj.nextLine();

                    ArrayList<String> app = new ArrayList<>();
                    if(input2.equals("E")){
                        System.out.println("GoodBye You are signed out!");
                        con.close();
                        return;
                    }
                    try {
                        PreparedStatement myStmt = con.prepareStatement("SELECT ATIME,'P' AS TYPE,MOTHER.name,MOTHER.QHCID\n" +
                                "FROM APPOINTMENT LEFT JOIN COUPLE C2 on C2.COUPLEID = APPOINTMENT.COUPLEID and APPOINTMENT.PRACTITIONERID=C2.MIDWIFE\n" +
                                "LEFT JOIN MOTHER  on C2.QHCID = MOTHER.QHCID\n" +
                                "WHERE APPOINTMENT.DATE=? AND C2.MIDWIFE =?\n" +
                                "UNION SELECT ATIME,'B' AS TYPE,MOTHER.name,MOTHER.QHCID\n" +
                                "FROM APPOINTMENT LEFT JOIN COUPLE C3 on APPOINTMENT.COUPLEID = C3.COUPLEID AND APPOINTMENT.PRACTITIONERID=C3.BACKUPMIDWIFE\n" +
                                "LEFT JOIN MOTHER  on C3.QHCID = MOTHER.QHCID\n" +
                                "WHERE APPOINTMENT.DATE=? AND C3.BACKUPMIDWIFE=?\n" +
                                "ORDER BY ATIME;\n");
                        myStmt.setString(1, input2);
                        myStmt.setString(2, input);
                        myStmt.setString(3, input2);
                        myStmt.setString(4, input);
                        java.sql.ResultSet rs = myStmt.executeQuery();
                        int count = 1;
                        while (rs.next()) {
                            String atime = rs.getString(1);
                            String type = rs.getString(2);
                            String name = rs.getString(3);
                            String qhcid = rs.getString(4);
                            app.add(atime);
                            //System.out.println(count + ":" + " " + atime + " " + type + " " + name + " " + qhcid);
                            count++;
                        }
                    } catch (SQLException e) {
                        sqlCode = e.getErrorCode(); // Get SQLCODE
                        sqlState = e.getSQLState(); // Get SQLSTATE
                        System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                        System.out.println(e);
                    }

                    if (app.size() == 0) {
                        System.out.println("there is no appointment on the given date");

                    } else {
                        while (true) {
                            PreparedStatement myStmtt = con.prepareStatement("SELECT ATIME,'P' AS TYPE,MOTHER.name,MOTHER.QHCID\n" +
                                    "FROM APPOINTMENT LEFT JOIN COUPLE C2 on C2.COUPLEID = APPOINTMENT.COUPLEID and APPOINTMENT.PRACTITIONERID=C2.MIDWIFE\n" +
                                    "LEFT JOIN MOTHER  on C2.QHCID = MOTHER.QHCID\n" +
                                    "WHERE APPOINTMENT.DATE=? AND C2.MIDWIFE =?\n" +
                                    "UNION SELECT ATIME,'B' AS TYPE,MOTHER.name,MOTHER.QHCID\n" +
                                    "FROM APPOINTMENT LEFT JOIN COUPLE C3 on APPOINTMENT.COUPLEID = C3.COUPLEID AND APPOINTMENT.PRACTITIONERID=C3.BACKUPMIDWIFE\n" +
                                    "LEFT JOIN MOTHER  on C3.QHCID = MOTHER.QHCID\n" +
                                    "WHERE APPOINTMENT.DATE=? AND C3.BACKUPMIDWIFE=?\n" +
                                    "ORDER BY ATIME;\n");
                            myStmtt.setString(1, input2);
                            myStmtt.setString(2, input);
                            myStmtt.setString(3, input2);
                            myStmtt.setString(4, input);
                            java.sql.ResultSet rss = myStmtt.executeQuery();
                            int countt = 1;
                            while (rss.next()) {
                                String atime = rss.getString(1);
                                String type = rss.getString(2);
                                String name = rss.getString(3);
                                String qhcid = rss.getString(4);
                                System.out.println(countt + ":" + " " + atime + " " + type + " " + name + " " + qhcid);
                                countt++;
                            }
                            System.out.println("Enter the appointment number that you would like to work on.\n" +
                                    "[E] to exit [D] to go back to another date :");
                            String input3 = myObj.nextLine();
                            if(input3.equals("D")){
                                break;
                            }


                            if (input3.equals("E")) {
                                System.out.println("GoodBye You are signed out!");
                                con.close();
                                return;
                            }
                            else {
                                String num = input3;
                                int mynum = Integer.parseInt(num);
                                if (mynum <= app.size()) {
                                   while(true){
                                       PreparedStatement myStmt = con.prepareStatement("SELECT ATIME,'P' AS TYPE,MOTHER.name,MOTHER.QHCID,APPOINTMETID,PREGID,C2.COUPLEID\n" +
                                                   "FROM APPOINTMENT LEFT JOIN COUPLE C2 on C2.COUPLEID = APPOINTMENT.COUPLEID and APPOINTMENT.PRACTITIONERID=C2.MIDWIFE\n" +
                                                   "LEFT JOIN MOTHER  on C2.QHCID = MOTHER.QHCID\n" +
                                                   "WHERE APPOINTMENT.DATE=? AND C2.MIDWIFE =?\n" +
                                                   "UNION SELECT ATIME,'B' AS TYPE,MOTHER.name,MOTHER.QHCID,APPOINTMETID,PREGID,C3.COUPLEID\n" +
                                                   "FROM APPOINTMENT LEFT JOIN COUPLE C3 on APPOINTMENT.COUPLEID = C3.COUPLEID AND APPOINTMENT.PRACTITIONERID=C3.BACKUPMIDWIFE\n" +
                                                   "LEFT JOIN MOTHER  on C3.QHCID = MOTHER.QHCID\n" +
                                                   "WHERE APPOINTMENT.DATE=? AND C3.BACKUPMIDWIFE=?\n" +
                                                   "ORDER BY ATIME;\n");
                                           myStmt.setString(1, input2);
                                           myStmt.setString(2, input);
                                           myStmt.setString(3, input2);
                                           myStmt.setString(4, input);
                                           java.sql.ResultSet rs = myStmt.executeQuery();
                                           int count = 1;
                                           int qhcidm = 0;
                                           int appidm = 0;
                                           int preg=0;
                                           int cid=0;
                                           while (rs.next()) {
                                               String atime = rs.getString(1);
                                               String type = rs.getString(2);
                                               String name = rs.getString(3);
                                               int qhcid = rs.getInt(4);
                                                int appid = rs.getInt(5);
                                                int pre=rs.getInt(6);
                                                int cidd = rs.getInt(7);
                                               app.add(atime);
                                               if(count==mynum){
                                                   qhcidm = qhcid;
                                                   appidm = appid;
                                                   preg=pre;
                                                   cid=cidd;
                                                   System.out.println( "For" +" " + atime +  " " + name + " " + qhcid);
                                               }

                                               count++;
                                           }


                                       System.out.println("1. Review notes\n" +
                                               "2. Review tests\n" +
                                               "3. Add a note\n" +
                                               "4. Prescribe a test\n" +
                                               "5. Go back to the appointments.\n" +
                                               "Enter your choice:");
                                       String input4 = myObj.nextLine();

                                       if(input4.equals("1")){
                                           try{
                                           PreparedStatement myStmt2 = con.prepareStatement("SELECT NOTE.DATETIME, NTIME,CONTENT\n" +
                                                   "FROM NOTE LEFT JOIN APPOINTMENT A on A.APPOINTMETID = NOTE.APPOINTMETID\n" +
                                                   "LEFT JOIN COUPLE C2 on C2.COUPLEID = A.COUPLEID\n" +
                                                   "LEFT JOIN MOTHER M on M.QHCID = C2.QHCID\n" +
                                                   "WHERE M.QHCID=?AND A.APPOINTMETID=?" +
                                                   "ORDER BY NTIME DESC;");

                                               myStmt2.setInt(1,qhcidm);
                                               myStmt2.setInt(2,appidm);
                                               java.sql.ResultSet rs2 = myStmt2.executeQuery();



                                               while (rs2.next()) {
                                               String date = rs2.getString(1);
                                               String time = rs2.getString(2);
                                               String content = rs2.getString(3);
                                               String newcont = content.substring(0,Math.min(content.length(),50));
                                               System.out.println(date + " " + time + " " + newcont);

                                           }
                                       } catch (SQLException e) {
                                           sqlCode = e.getErrorCode(); // Get SQLCODE
                                           sqlState = e.getSQLState(); // Get SQLSTATE
                                           System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                                           System.out.println(e);
                                       }

                                       }
                                       if(input4.equals("2")){
                                           try{
                                               PreparedStatement myStmt2 = con.prepareStatement("SELECT DISTINCT PERSCRIBEDDATE,TYPE,RESULT\n" +
                                                       "FROM APPOINTMENT JOIN TEST T on APPOINTMENT.PREGID = T.PREGID\n" +
                                                       "WHERE APPOINTMENT.PREGID = ?;");

                                               myStmt2.setInt(1,preg);

                                               java.sql.ResultSet rs2 = myStmt2.executeQuery();



                                               while (rs2.next()) {
                                                   String date = rs2.getString(1);
                                                   String type = rs2.getString(2);
                                                   String content = rs2.getString(3);
                                                   if(content ==null){
                                                       System.out.println(date + " " +"["+ type+"]" + " " + "pending");
                                                   }else{
                                                       String newcont = content.substring(0,Math.min(content.length(),50));
                                                       System.out.println(date + " " +"["+ type+"]" + " " + newcont);
                                                   }


                                               }
                                           } catch (SQLException e) {
                                               sqlCode = e.getErrorCode(); // Get SQLCODE
                                               sqlState = e.getSQLState(); // Get SQLSTATE
                                               System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                                               System.out.println(e);
                                           }


                                       }
                                       if(input4.equals("3")){

                                           Scanner myOb = new Scanner(System.in);
                                           System.out.println("Please type your observation:");
                                           String content = myOb.nextLine();
                                           java.sql.ResultSet rs3 = statement.executeQuery("SELECT NOTEID FROM NOTE ORDER BY NOTEID DESC LIMIT 1\n");
                                           int nid =0;
                                               while (rs3.next()) {
                                                    nid = rs3.getInt(1)+1;

                                               }


                                           PreparedStatement myStmt3 = con.prepareStatement("INSERT INTO NOTE(noteid, datetime, practitionerid, appointmetid, content, ntime)\n" +
                                                   "VALUES (?,current_date ,?,?,?,current_time );");

                                           myStmt3.setInt(1,nid);
                                           myStmt3.setInt(2,Integer.parseInt(input));
                                           myStmt3.setInt(3,appidm);
                                           myStmt3.setString(4,content);
                                           myStmt3.executeUpdate();
                                       }
                                       if(input4.equals("4")){
                                           Scanner myOb = new Scanner(System.in);
                                           System.out.println("Please enter the type of test:");
                                           String TYPE = myOb.nextLine();
                                           java.sql.ResultSet rs3 = statement.executeQuery("SELECT TESTID FROM TEST ORDER BY TESTID DESC LIMIT 1\n");
                                           int tid =0;
                                           while (rs3.next()) {
                                               tid = rs3.getInt(1)+1;
                                           }

                                          PreparedStatement myStmt3 = con.prepareStatement("INSERT INTO TEST(TESTID, TECHNICIANID, PREGID, TESTDATE, TYPE, PERSCRIBEDDATE, SAMPLETAKENDATE, EXPECTEDDUEDATE, RESULT, PRACTITIONERID, COUPLEID)\n" +
                                                   "VALUES (?,8881,?,NULL,?,CURRENT_DATE,CURRENT_DATE,NULL,NULL,?,?)");

                                           myStmt3.setInt(1,tid);
                                           myStmt3.setInt(2,preg);
                                           myStmt3.setString(3,TYPE);
                                           myStmt3.setInt(4,Integer.parseInt(input));
                                           myStmt3.setInt(5,cid);
                                           myStmt3.executeUpdate();
                                       }
                                       if(input4.equals("5")){
                                           break;
                                       }

                                   }

                                }

                            }
                        }
                    }
                }

            }
        }
    }
}

