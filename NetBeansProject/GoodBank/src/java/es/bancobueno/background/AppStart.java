/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.bancobueno.background;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author berik
 */
public class AppStart implements ServletContextListener
    {

    private ScheduledExecutorService saves, debts, interests;

    @Override
    public void contextDestroyed(ServletContextEvent arg0)
	{
	System.out.println("Tareas en segundo plano detenidas");
	saves.shutdown();
	debts.shutdown();
	interests.shutdown();
	}

    @Override
    public void contextInitialized(ServletContextEvent arg0)
	{
	saves = Executors.newSingleThreadScheduledExecutor();
	debts = Executors.newSingleThreadScheduledExecutor();
	interests = Executors.newSingleThreadScheduledExecutor();
	saves.scheduleWithFixedDelay(new UpdateSavesAccounts(), 28, 600, TimeUnit.SECONDS);
	debts.scheduleWithFixedDelay(new UpdateDebtsAccounts(), 22, 600, TimeUnit.SECONDS);
	interests.scheduleWithFixedDelay(new UpdateInterestAccounts(), 19, 600, TimeUnit.SECONDS);
	}
    }
