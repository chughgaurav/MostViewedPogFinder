package com.sd;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Timer;
import java.util.TimerTask;

import com.aerospike.client.AerospikeClient;
import com.aerospike.client.AerospikeException;
import com.aerospike.client.Bin;
import com.aerospike.client.Key;
import com.aerospike.client.Record;
import com.aerospike.client.Value;
import com.aerospike.client.large.LargeSet;
import com.aerospike.client.lua.LuaConfig;
import com.aerospike.client.policy.WritePolicy;

/**
 * Hello world!
 *
 */
public class Database 
{
	public static int counter=1,counter2=0;

	private Database(){
        AerospikeClient client = new AerospikeClient("127.0.0.1", 3000);
        
        try{
        	// Initialize policy.
        	WritePolicy writePolicy = new WritePolicy();
        	writePolicy.timeout = 500;  // 50 millisecond timeout.
        	Key key = new Key("test", "demo2", "pogIdList");
            
            client.delete(writePolicy, key);
            System.out.println("clearing database");
        	
        }
        catch(Exception e){
        	e.printStackTrace();
        }
        finally {
            client.close();
        }
	}
	
    public static void main( String[] args )
    {
        Database obj = new Database();
        
        
        
    }
    
    public void storePogIdToAerospike(String pogId){
        AerospikeClient client = new AerospikeClient("127.0.0.1", 3000);

        try{
        	// Initialize policy.
        	WritePolicy writePolicy = new WritePolicy();
        	writePolicy.timeout = 500;  // 50 millisecond timeout.

        	Key key = new Key("test", "demo2", "pogIdList");
        	Bin bin1 = new Bin(pogId, 1);
        	//client.put(writePolicy, key, bin1);
        	
        	//add updates value
        	//client.add(writePolicy, key, bin1);
        	
        	String result = String.valueOf(
        			client.execute(writePolicy, key, "storePogIdInQueue", "storePogIdInQueue",Value.get(pogId))
        			);
        	
        	System.out.println("result: " + result);
        	
        	// Read a single value.
        	Record record = client.get(writePolicy, key, pogId);            
        	
        	if (record != null) {
        		System.out.println("pogList: " + record.getValue(pogId));
        	}
        	
        }
        catch(Exception e){
        	e.printStackTrace();
        }
        finally {
            client.close();
            System.out.println("exiting.....");
        }
	}
    
    public static void runTestLdt() throws AerospikeException {
        LuaConfig.SourceDirectory = "udf";

        AerospikeClient client = new AerospikeClient("127.0.0.1", 3000);

        try {
            WritePolicy policy = new WritePolicy();
            Key key = new Key("test", "demoset", "setkey");
            String binName = "setbin";

            // Delete record if it already exists.
            client.delete(policy, key);

            // Initialize large set operator.
            LargeSet set = client.getLargeSet(policy, key, binName, null);

            // Write values.
            set.add(Value.get("setvalue1"));
            set.add(Value.get("setvalue2"));

            // Verify large set was created with default configuration.
            Map<?,?> map = set.getConfig();

            for (Entry<?,?> entry : map.entrySet()) {
                System.out.println(entry.getKey().toString() + ',' + entry.getValue());
            }

            System.out.println("Size: " + set.size());

            Object received = set.get(Value.get("setvalue2"));
            System.out.println("Found: " + received);
        }
        finally {
            client.close();
        }
    }
    
    public static void runTest(int counter) throws AerospikeException {
        AerospikeClient client = new AerospikeClient("127.0.0.1", 3000);
        
        //System.out.println("in runtest -"+counter);
        
        
        
        try {        	
        	Key key = new Key("test", "demo2", "pogIdList");
        	//Bin bin1 = new Bin("bin1", "value14");
        	//Bin bin2 = new Bin("bin2", "value2");

        	WritePolicy writePolicy = new WritePolicy();
        	//writePolicy.expiration = 10;
        	// Write a record
        	//client.put(writePolicy, key, bin1, bin2);
        	
        	// Read a record
        	//Record record = client.get(null, key);
        	
        	String result = String.valueOf(
        			client.execute(writePolicy, key, "examples", "readBin", Value.get("pogId"))
        			);
        	System.out.println("hello- "+result);
        	
        	/*
        	if (record != null) {
                System.out.println("Found record: Expiration=" + record.expiration + " Generation=" + record.generation);
                for (Map.Entry<String,Object> entry : record.bins.entrySet()) {
                    System.out.println("Name=" + entry.getKey() + " Value=" + entry.getValue());
                }
            }
        	*/
        	
        	
        	/*
            // Initialize policy.
            WritePolicy policy = new WritePolicy();
            policy.timeout = 500;  // 50 millisecond timeout.
 
            // Write a single value.
            Key key = new Key("test", "", "codecentric");
 
            // Read a single value.
            Record record = client.get(policy, key, "name");            
 
            if (record != null) {
                System.out.println("Got name: " + record.getValue("name"));
            }
 
            // Read multiple values.
            record = client.get(policy, key);
 
            if (record != null) {
                System.out.println("Found record: Expiration=" + record.expiration + " Generation=" + record.generation);
                for (Map.Entry<String,Object> entry : record.bins.entrySet()) {
                    System.out.println("Name=" + entry.getKey() + " Value=" + entry.getValue());
                }
            }
 
            // Delete record.
            client.delete(policy, key);
            */       
        }
        finally {
            client.close();
            System.out.println("exiting.....runTest");
        }
    }
}