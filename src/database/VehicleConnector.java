package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import bean.LotBean;
import bean.VehicleBean;

public class VehicleConnector {

	private ConnectionPoolManager pool;
	private Connection connection;
	private PreparedStatement preparedStatement;
	private ResultSet resultSet;

	public VehicleConnector() {
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
	private VehicleBean readBeanData(ResultSet resultSet) {
	    VehicleBean bean = new VehicleBean();
	    try {
	    	bean.setNumb(resultSet.getInt("numb"));
	    	bean.setRegi(resultSet.getBoolean("regi"));
	    	bean.setDayp(resultSet.getBoolean("dayp"));
	    	bean.setStat(resultSet.getBoolean("stat"));
	    	bean.setCnum(resultSet.getString("cnum"));
	    	bean.setType(resultSet.getString("type"));
	    	bean.setPlot(resultSet.getInt("plot"));
	    	bean.setDeta(resultSet.getInt("deta"));
	    } catch (Exception e) {
	    e.printStackTrace();
	    }
	    return bean;
	}
	public int insertVehicle(VehicleBean bean) {
		int result = 0;
	    try {
	        Initializer("insert into "
	                  + "vehicle(regi,dayp,stat,cnum,type,plot)"
	                  + "values(?,?,?,?,?,?)");
	        preparedStatement.setBoolean(1, bean.getRegi());
	        preparedStatement.setBoolean(2, bean.getDayp());
	        preparedStatement.setBoolean(3, bean.getStat());
	        preparedStatement.setString(4, bean.getCnum());
	        preparedStatement.setString(5, bean.getType());
	        preparedStatement.setInt(6, bean.getPlot());
			result = preparedStatement.executeUpdate();
			return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement);
		}
		return result;

	}
	public int updateVehiclePlot(int plot, int numb) {
		int result = 0;
		try {
			Initializer("UPDATE vehicle SET plot=? WHERE numb=?");
				preparedStatement.setInt(1, plot);
				preparedStatement.setInt(2, numb);
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateVehicleDeta(int deta, int numb) {
		int result = 0;
		try {
			Initializer("UPDATE vehicle SET deta=? WHERE numb=?");
				preparedStatement.setInt(1, deta);
				preparedStatement.setInt(2, numb);
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateVehicleType(String type, int numb) {
		int result = 0;
		try {
			Initializer("UPDATE vehicle SET type=? WHERE numb=?");
				preparedStatement.setString(1, type);
				preparedStatement.setInt(2, numb);
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateVehicleStat(boolean bool, int numb) {
		int result = 0;
		try {
			Initializer("UPDATE vehicle SET stat=? WHERE numb=?");
				preparedStatement.setBoolean(1, bool);
				preparedStatement.setInt(2, numb);
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateVehicleRegi(boolean bool, int numb) {
		int result = 0;
		try {
			Initializer("UPDATE vehicle SET regi=? WHERE numb=?");
				preparedStatement.setBoolean(1, bool);
				preparedStatement.setInt(2, numb);
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateVehicleDayp(boolean bool, int numb) {
		int result = 0;
		try {
			Initializer("UPDATE vehicle SET dayp=? WHERE numb=?");
				preparedStatement.setBoolean(1, bool);
				preparedStatement.setInt(2, numb);
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public VehicleBean readVehicleByCnum(String cnum) {
		VehicleBean bean = new VehicleBean();
		try {
	        Initializer("select * from vehicle where cnum=?");
	        preparedStatement.setString(1, cnum);
	        this.resultSet = preparedStatement.executeQuery();
	        if (resultSet.next()) {
	        	bean = readBeanData(resultSet);
	        }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return bean;
	}
	public int readVehicleNumbByCnum(String cnum) {
		int result = 0;
		try {
	        Initializer("select numb from vehicle where cnum=?");
	        preparedStatement.setString(1, cnum);
	        this.resultSet = preparedStatement.executeQuery();
	        if (resultSet.next()) {
	        	result = resultSet.getInt("numb");
	        }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return result;
	}
	// getParkedVehicleList
	public Vector<VehicleBean> readParkedVehicles(int plot) {
	    Vector<VehicleBean> vector = new Vector<VehicleBean>();
	    try {
	        Initializer("select * from vehicle where plot=? and stat=1");
	        preparedStatement.setInt(1, plot);
	        this.resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	        	VehicleBean bean = readBeanData(resultSet);
	            vector.add(bean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(connection, preparedStatement, resultSet);
	    }
	    return vector;
		
	}
	public VehicleBean readParkedVehicleByNumb(int numb) {
	    VehicleBean bean = null;
	    try {
	        Initializer("select * from vehicle where numb=?");
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
	public VehicleBean readParkedVehicleByCnum(int cnum) {
	    VehicleBean bean = null;
	    try {
	        Initializer("select * from vehicle where cnum=?");
	        preparedStatement.setInt(1, cnum);
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
}