public with sharing class ContractDataFactory {

    // méthode de création des contrats de test 
    public static List<Contract> createContract(integer numContract, Id accountId){

        //Ajout des contrats de test 
        List<Contract> contracts = New List<Contract>();

        for(integer i= 0; i< numContract; i++){

            Contract contract = new Contract(
                AccountId = accountId,
                StartDate = System.today(),
                ContractTerm = 12,
                Status = 'Draft'
            );

            contracts.add(contract);

        }
        return contracts;
    }

    public void insertContracts(List<Contract> contracts){

        insert contracts;
    }
}