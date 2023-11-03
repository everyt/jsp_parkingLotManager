package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import bean.LotBean;

public class LotConnector {

	private ConnectionPoolManager pool;
	private Connection connection;
	private PreparedStatement preparedStatement;
	private ResultSet resultSet;

	public LotConnector() {
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
	
	public String readLotNameByNumb(int numb) {
		String name = "";
		try {
			Initializer("SELECT name FROM lot WHERE numb=?");
				preparedStatement.setInt(1, numb);
				resultSet = preparedStatement.executeQuery();
				if (resultSet.next()) {
					name = resultSet.getString("name");
				}
				pool.freeConnection(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return name;
	}
	public int readLotNumbByName(String name) {
		int numb = 0;
		try {
			Initializer("SELECT numb FROM lot WHERE name=?");
				preparedStatement.setString(1, name);
				resultSet = preparedStatement.executeQuery();
				if (resultSet.next()) {
					numb = resultSet.getInt("numb");
				}
				pool.freeConnection(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return numb;
	}
	public String readLotPswdByNumb(int numb) {
		String pswd = "";
		try {
			Initializer("SELECT pswd FROM lot WHERE numb=?");
				preparedStatement.setInt(1, numb);
				resultSet = preparedStatement.executeQuery();
		        if (resultSet.next()) {
		            pswd = resultSet.getString("pswd");
		        }
				pool.freeConnection(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pswd;
	}
	public int insertLot(LotBean bean) {
		int result = 0;
		try {
			Initializer("INSERT lot(name, pswd, pric, perh, perd, free) VALUES (?,?,?,?,?,?)");
				preparedStatement.setString(1, bean.getName());
				preparedStatement.setString(2, bean.getPswd());
				preparedStatement.setInt(3, bean.getPric());
				preparedStatement.setInt(4, bean.getPerh());
				preparedStatement.setInt(5, bean.getPerd());
				preparedStatement.setInt(6, bean.getFree());
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection, preparedStatement);
				return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int login(String name, String pswd) {
		int result = 0;
		try {
			Initializer("SELECT numb FROM lot WHERE name=? and pswd=?");
				preparedStatement.setString(1, name);
				preparedStatement.setString(2, pswd);
				resultSet = preparedStatement.executeQuery();
		        if (resultSet.next()) {
		        	result = resultSet.getInt("numb");
		        }
				pool.freeConnection(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateLot(LotBean bean) {
		int result = 0;
		try {
			Initializer("UPDATE lot SET name=?,pswd=?,pric=?,perh=?,perd=?,free=? WHERE numb=?");
				preparedStatement.setString(1, bean.getName());
				preparedStatement.setString(2, bean.getPswd());
				preparedStatement.setInt(3, bean.getPric());
				preparedStatement.setInt(4, bean.getPerh());
				preparedStatement.setInt(5, bean.getPerd());
				preparedStatement.setInt(6, bean.getFree());
				preparedStatement.setInt(7, bean.getNumb());
				result = preparedStatement.executeUpdate();
				pool.freeConnection(connection, preparedStatement);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int deleteLot(int numb) {
		try {
			Initializer("DELETE FROM lot WHERE numb=?");
				preparedStatement.setInt(1, numb);
				int result = preparedStatement.executeUpdate();
				pool.freeConnection(connection);
				return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public LotBean readLotByNumb(int numb) {
		LotBean bean = null;
		try {
			Initializer("SELECT * FROM lot WHERE numb=?");
			preparedStatement.setInt(1, numb);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				bean = new LotBean();
				bean.setName(resultSet.getString("name"));
				bean.setPswd(resultSet.getString("pswd"));
				bean.setPric(resultSet.getInt("pric"));
				bean.setPerh(resultSet.getInt("perh"));
				bean.setPerd(resultSet.getInt("perd"));
				bean.setFree(resultSet.getInt("free"));
			}
			
	        pool.freeConnection(connection, preparedStatement, resultSet);
		} catch (Exception e) {
	        e.printStackTrace();
	    }
	    return bean;
	}
	public Vector<LotBean> readLots() {
		Vector<LotBean> vector = new Vector<LotBean>();
		try {
			Initializer("SELECT * FROM lot");
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				LotBean bean = new LotBean();
				bean.setNumb(resultSet.getInt("numb"));
				bean.setName(resultSet.getString("name"));
				bean.setPswd(resultSet.getString("pswd"));
				bean.setPric(resultSet.getInt("pric"));
				bean.setPerh(resultSet.getInt("perh"));
				bean.setPerd(resultSet.getInt("perd"));
				bean.setFree(resultSet.getInt("free"));
				vector.add(bean);
			}
	        pool.freeConnection(connection, preparedStatement, resultSet);
		} catch (Exception e) {
	        e.printStackTrace();
	    }
		return vector;
	}
}