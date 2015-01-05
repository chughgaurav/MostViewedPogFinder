package com.sd;

import java.util.Map;

import com.aerospike.client.AerospikeClient;
import com.aerospike.client.AerospikeException;
import com.aerospike.client.Bin;
import com.aerospike.client.Key;
import com.aerospike.client.Record;
import com.aerospike.client.Value;
import com.aerospike.client.policy.WritePolicy;

public class RollingStore {
	
	 int counter;
	
	public RollingStore(){
		this.counter = 0;
	}

	public static void main(String args[]){	
		RollingStore obj = new RollingStore();
		
		while(true){
			try {
				if(obj.counter>=5)
					obj.counter=1;
				else
					obj.counter += 1;
				
				obj.processPogListData(obj.counter);
				
				Thread.sleep(1000*5);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void processPogListData(int listNo){
		//stores into time based keys, at t[i] --> puts data to key[i]
        AerospikeClient client = new AerospikeClient("127.0.0.1", 3000);
        
        try{
        	// Initialize policy.
        	WritePolicy writePolicy = new WritePolicy();
        	writePolicy.timeout = 500;  // 50 millisecond timeout.

        	Key key = new Key("test", "demo2", "pogIdList");
        	
        	 // Read multiple values.
        	Record record = client.get(writePolicy, key);
 
            if (record != null) {
                System.out.println("Found record: Expiration=" + record.expiration + " Generation=" + record.generation);
                for (Map.Entry<String,Object> entry : record.bins.entrySet()) {
                    System.out.println("Name=" + entry.getKey() + " Value=" + entry.getValue());
                }
            }
            /*
        	String result = String.valueOf(
        			client.execute(writePolicy, key, "examples", "readBin", Value.get("pogId1"))
        			);
        			*/
            String result = String.valueOf(
        			client.execute(writePolicy, key, "storeCountInListNo", "storeCountInListNo", Value.get(listNo))
        			);
        	System.out.println("hello- "+result);
            
            // Delete record.
            client.delete(writePolicy, key);
        	
        }
        catch(Exception e){
        	e.printStackTrace();
        }
        finally {
            client.close();
            System.out.println("exiting.....");
        }
	}
	
	public void callUdf(){
		/*
		String result = (String) client.execute(
			    null, key, "examples", "readBin", Value.get("name")
			);
			*/
	}
}
