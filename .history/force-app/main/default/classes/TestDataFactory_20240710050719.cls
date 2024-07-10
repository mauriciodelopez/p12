/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-10-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class TestDataFactory {
    
    // Méthode pour créer des comptes à partir de l'objet Account de Salesforce
    public static List<Account> createAccounts(Integer numAccounts) {
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < numAccounts; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            acc.Id = null;
            accounts.add(acc);
        }
        insert accounts;    
        return accounts;
    }

        // Method to create a single order for each test account 
    public static List<Order> createOrdersForAccounts(List<Account> accounts) {
    return createOrdersForAccounts(accounts, 1);
    }

    // Méthode pour créer une seule commande pour chaque compte de test
    public static List<Order> createOrdersForAccounts(List<Account> accounts, Integer numOrdersPerAccount) {
    List<Order> orders = new List<Order>();
    for(Account acc : accounts) {
        for(Integer i = 0; i < numOrdersPerAccount; i++) {
            Order ord = new Order(AccountId = acc.Id, EffectiveDate = Date.today(), Status = 'Draft', Pricebook2Id = Test.getStandardPricebookId());
            orders.add(ord);
        }
    }
    insert orders;
    return orders;
    }

    // Méthode pour créer des produits pour les commandes de test
    public static Product2 createProduct(String name, String family) {
        Product2 prod = new Product2(Name = name, Family = family);
        insert prod;
        return prod;
    }

    // Methode pour créer a pricebookentry pour un produit
    public static PricebookEntry createPricebookEntry(Product2 product, Decimal unitPrice) {
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = unitPrice,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }
    // Méthode pour créer une commande pour un compte
    public static Order createOrder(Id accountId, String orderStatus) {
        Order order = new Order(
            AccountId = accountId,
            EffectiveDate = System.today(),
            Status = orderStatus,
            PriceBook2Id = Test.getStandardPricebookId()
        );
        insert order;
        return order;
    }

    // Méthode pour créer un OrderItem pour chaque commande
    public static List<OrderItem> createOrderItems(List<Order> orders, Id pricebookEntryId, Integer quantity, Decimal unitPrice) {
        return createOrderItems(orders, pricebookEntryId, quantity, unitPrice, 1);
    }

    // Méthode pour créer plusieurs OrderItem pour chaque commande
    public static List<OrderItem> createOrderItems(List<Order> orders, Id pricebookEntryId, Integer quantity, Decimal unitPrice, Integer numOrderItemsPerOrder) {
        List<OrderItem> orderItems = new List<OrderItem>();
            for(Order ord : orders) {
                for(Integer i = 0; i < numOrderItemsPerOrder; i++) {
                OrderItem oi = new OrderItem(OrderId = ord.Id, PricebookEntryId = pricebookEntryId, Quantity = quantity, UnitPrice = unitPrice);
                orderItems.add(oi);
                }
            }    
            insert orderItems;
            return orderItems;
    }

    // Methode pour  create taches pour chaque compte
    public static List<Task> createTasksForAccounts(List<Account> accounts) {
        List<Task> tasks = new List<Task>();
        for(Account acc : accounts) {
            Task task = new Task(
                WhatId = acc.Id,
                Subject = 'Call',
                TaskSubtype = 'Call',
                Status = 'New',
                Priority = 'Normal',
                IsReminderSet = true,
                ReminderDateTime = System.today().addDays(5)
            );
            tasks.add(task);
        }
        insert tasks;
        return tasks;
    }
}