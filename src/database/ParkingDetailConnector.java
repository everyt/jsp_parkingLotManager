package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import bean.ParkingDetailBean;

public class ParkingDetailConnector {

	private ConnectionPoolManager pool;
	private Connection connection;
	private PreparedStatement preparedStatement;
	private ResultSet resultSet;

	public ParkingDetailConnector() {
		try {
			pool = ConnectionPoolManager.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//초기화
	private void Initializer(String query) {
		try {
			this.connection = pool.getConnection();
			this.preparedStatement = connection.prepareStatement(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private ParkingDetailBean readBeanData(ResultSet resultSet) {
		ParkingDetailBean bean = new ParkingDetailBean();
	    try {
	    	bean.setNumb(resultSet.getInt("numb"));
	    	bean.setVeid(resultSet.getInt("veid"));
	    	bean.setEnte(resultSet.getTimestamp("ente"));
	    	bean.setLeav(resultSet.getTimestamp("leav"));
	    	bean.setPlot(resultSet.getInt("plot"));
	    } catch (Exception e) {
	    e.printStackTrace();
	    }
	    return bean;
	}
	
	public int insertParkingDetail(ParkingDetailBean bean) {
	    int result = 0;
	    try {
	        Initializer("insert into "
	                  + "parkingdetail(veid,ente,plot)"
	                  + "values(?,?,?)");
	        preparedStatement.setInt(1, bean.getVeid());
	        preparedStatement.setTimestamp(2, bean.getEnte());
	        preparedStatement.setInt(3, bean.getPlot());
	        result = preparedStatement.executeUpdate();
			return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement);
	    }
	    return result;
	}
	// getParkingDetailList
	public Vector<ParkingDetailBean> readParkingDetails(int attachedParkingLot) {
	    Vector<ParkingDetailBean> vector = new Vector<ParkingDetailBean>();
	    try {
	        Initializer("select * from parkingDetail where plot=?");
	        preparedStatement.setInt(1, attachedParkingLot);
	        this.resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	        	ParkingDetailBean bean = readBeanData(resultSet);
	            vector.add(bean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement, resultSet);
	    }
	    return vector;
	}
	public ParkingDetailBean readParkingDetailByNumb(int numb) {
		ParkingDetailBean bean = null;
	    try {
	        Initializer("select * from parkingDetail where numb=?");
	        preparedStatement.setInt(1, numb);
	        this.resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	        	bean = readBeanData(resultSet);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement, resultSet);
	    }
	    return bean;
		
	}
	public int readParkingDetailNumb(ParkingDetailBean bean) {
	    int result = 0;
	    try {
	    	Initializer("SELECT numb FROM parkingDetail " + 
	    				"WHERE veid = ? AND plot = ? " + 
	                	"ORDER BY ente DESC " + 
	    				"LIMIT 1;");
	        preparedStatement.setInt(1, bean.getVeid());
	        preparedStatement.setInt(2, bean.getPlot());
	        this.resultSet = preparedStatement.executeQuery();
	        if (resultSet.next()) {
	        	result = resultSet.getInt("numb");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement);
	    }
	    return result;
		
	}
	public int updateParkingDetailLeav(ParkingDetailBean bean) {
	    int result = 0;
	    try {
	    	Initializer("SELECT * FROM parkingDetail " + 
	    				"WHERE veid = ? AND plot = ? " + 
	                	"ORDER BY ente DESC " + 
	    				"LIMIT 1;");
	        preparedStatement.setInt(1, bean.getVeid());
	        preparedStatement.setInt(2, bean.getPlot());
	        this.resultSet = preparedStatement.executeQuery();
	        if (resultSet.next()) {
	        	result = resultSet.getInt("numb");
	            int parkingDetailPid = resultSet.getInt("numb");
	        	String updateQuery = "UPDATE parkingDetail SET leav = ? WHERE numb = ?";
	            preparedStatement = connection.prepareStatement(updateQuery);
	            preparedStatement.setTimestamp(1, bean.getLeav());
	            preparedStatement.setInt(2, parkingDetailPid);
	            preparedStatement.executeUpdate();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement);
	    }
	    return result;
		
	}
}
