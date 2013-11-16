/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package es.bancobueno.servlets;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author berik
 */
 public class AppStart implements ServletContextListener{
 private ScheduledExecutorService scheduler,scheduler2;
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("ServletContextListener destroyed");
		scheduler.shutdown();
		scheduler2.shutdown();
	}
 
	
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		System.out.println("Prueba started");
		scheduler = Executors.newSingleThreadScheduledExecutor();
		scheduler2 = Executors.newSingleThreadScheduledExecutor();
		//scheduler.scheduleAtFixedRate(new UpdateSavesAccounts(), 0, 12, TimeUnit.MINUTES);
		//scheduler2.scheduleAtFixedRate(new UpdateDebtsAccounts(), 0, 8, TimeUnit.MINUTES);
	}
}