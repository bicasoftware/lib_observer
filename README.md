# Lib Observer

Lib Observer é um pacote de widgets com intuito de oferecer uma sintaxe mais simples para a utilização do FutureBuilder e do StreamBuilder que por sua vez requisitam que sempre exista um tratamento do **AsyncSnapshot** verificando os atributos **hasData** e **hasError**. O LibObserver fornece uma sintax mais simples e padronização desses dois widgets.

## Widgets disponíveis:
  - FutureObserver
  - StreamObserver
  - MergedStreamObserver

---

## Utilização


##### FutureObserver

FutureObserver recebe um Future e ao concluir o chama o método onSuccess

    FutureObserver<int>(
      future: myFuture,
      onSuccess: (BuildContext c, int myInt) {
        return Text(myInt.toString());
      }
    )

##### StreamObserver

StreamObserver recebe um Stream e ao concluir o chama o método onSuccess

    StreamObserver<String>(
      stream: myStream,
      onSuccess: (BuildContext c, String myString) {
        return Text(myString);
      }
    )
  
##### MergedStreamObserver

MergedStreamObserver funciona igual ao StreamObserver, porém ele recebe uma  lista de Streams e ao concluir todas as Streams, chama o método onSuccess contendo uma List<Object\> com os resultados

    MergedStreamObserver(
      streams: [streamSalario, streamNome],
      onSuccess: (BuildContext c, List<Object> myData) {
        final salario = myData[0] as double;
        final nome = myData[1] as String;
        return Text("O Cliente $nome recebe o salário de $salario");
      }
    )