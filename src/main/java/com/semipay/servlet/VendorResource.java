package com.semipay.servlet;

import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.semipay.dao.VendorDAO;
import com.semipay.model.Vendor;

/**
 * Root resource (exposed at "vendor" path)
 */
@Path("/vendor")
public class VendorResource {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
	private VendorDAO vendorDAO;
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Vendor> getIt() {
    	vendorDAO = new VendorDAO();
        return vendorDAO.getAll();
    	/*Vendor vendor = new Vendor();
    	vendor.setId(1);
    	vendor.setName("Bharat Petroleum");
    	vendor.setIsActive(true);
    	
    	return vendor;*/
    }
}
