import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2

Window {
    visible: true
    id: page
    title: qsTr("Jogo da Velha")
    width: 500
    height: 500
    minimumHeight: 200
    minimumWidth: 200
     color: "#0036f9"
     property var mode: Item{ visible: false}

     Rectangle{
         id: menu
         color: "transparent"
         width: parent.width *(3/5)
         height: parent.height *(3/5)
         z: 2
         anchors.centerIn: parent
        Column{
         spacing: 10
         anchors.fill: parent

        Rectangle{
            id: start
            visible: true
            width: 120
            height: 60
            color: "#B388FF"
            border.color: "yellow"
            border.width: 3
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 8
            Text {
                text: qsTr("jogar com\noutro jogador")
                font.bold: true
                font.pixelSize: 14
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    menu.visible = false
                    game.visible = true
                    mode = game
                }
            }
        }
        Rectangle{
            id: startpc
            visible: true
            width: 120
            height: 60
            color: "#B388FF"
            border.color: "yellow"
            border.width: 3
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 8
            Text {
                text: qsTr("jogar contra\no computador")
                font.bold: true
                font.pixelSize: 14
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                   //jogo contra o pc
                    menu.visible = false
                    gamepc.visible = true
                    mode = gamepc
                }
            }
        }
        Rectangle{
            id: quit
            visible: true
            width: 120
            height: 60
            color: "#B388FF"
            border.color: "yellow"
            border.width: 3
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 8
            Text {
                text: qsTr("sair")
                font.bold: true
                font.pixelSize: 16
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    Qt.quit()
                }
            }

        }
         }
    }
     Rectangle{
         visible: menu.visible
         //color: "#B388FF"
         gradient: Gradient {
                GradientStop { position: 0.0; color: "#B388FF" }
                GradientStop { position: 0.5; color: "white" }
                GradientStop { position: 1.0; color: "#B388FF" }
            }
         width: 300
         height: 320
         x: parent.width/2 - 150
         y: parent.height * 0.1
         radius: 12
     }

    Item {
        id: game
        visible: false
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.centerIn: parent
        property int p1: 0
        property int p2: 0
        property int ties: 0
        property var player: 1
        property int round: 1
        //funçoes que reiniciam o jogo
        function clearrects(){
            var i;
            for(i=0; i<9; i++){
                row.itemAt(i).color = "white"
                row.itemAt(i).image.source = ""
            }
        }
        function reset(){
            game.clearrects()
            _grid.clear()
            game.player = 1
        }
        function clear(){
            game.reset()
            game.p1 = 0
            game.p2 = 0
            game.ties = 0
            game.round = 1           
        }

        Grid {
            id: cell
            anchors.verticalCenterOffset: 8
            anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                columns: 3
                spacing: 8

                Repeater {
                    id: row
                       model: 9
                       delegate: Rectangle {
                           height: game.height /3
                           width: game.height /3
                           color: "white"

                            Image {
                               id: img
                               visible: true
                               height: game.height * 0.3
                               width: parent.width * 0.9
                               anchors.centerIn: parent
                               source: ""
                               NumberAnimation{
                                   id: animateOpacity
                                   target: img
                                   property: "opacity"
                                   from: 0
                                   to: 1
                                   duration: 400
                               }
                           }
                           property var image: img

                           MouseArea{
                               anchors.fill: parent
                                onClicked: {
                                    if(_grid.atPos(index) == 0){
                                        //vez do 1º jogador
                                        if(game.player == 1){
                                            img.source = "images/x.png"
                                            animateOpacity.start()
                                            _grid.setValue(index, 1)
                                            game.player = 2
                                        }
                                        //vez do 2º jogador
                                        else{
                                            img.source = "images/o.png"
                                            animateOpacity.start()
                                            _grid.setValue(index, 2)
                                            game.player = 1
                                        }
                                        var aux =_grid.win()
                                        //verifica se há ganhador
                                        if(aux != 0){
                                            line(row)
                                            messageDialog.show(qsTr("jogador "+aux+" ganhou!"))
                                            if(aux==1) game.p1++;
                                            else game.p2++;                                           
                                        }
                                        //verifica se é empate
                                        else if(_grid.isFull()){
                                            messageDialog.show("empate!")
                                            game.ties++
                                        }
                                    }

                                }
                           }
                       }
                   }

               }

    }

    Item {
        id: gamepc
        visible: false
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.centerIn: parent
        property int p1: 0
        property int p2: 0
        property int ties: 0
        property var player: 1
        property int round: 1
        //função que seleciona um retangulo aleatório
        function pcRound(){
            var n = Math.round(Math.random()*8)
            while (_grid.atPos(n)!=0){
                n = Math.round(Math.random()*8)
            }
            row2.itemAt(n).image.source = "images/o.png"
            row2.itemAt(n).image.opacity = 0
            row2.itemAt(n).animate.start()
            _grid.setValue(n, 2)
            gamepc.player = 1

        }
        function rand(){
            var n = Math.random() * 8
            return n;
        }
        //funções que reiniciam o jogo
        function clearrects(){
            var i;
            for(i=0; i<9; i++){
                row2.itemAt(i).color = "white"
                row2.itemAt(i).image.source = ""
            }
        }
        function reset(){
            gamepc.clearrects()
            _grid.clear()
            gamepc.player = 1
        }
        function clear(){
            gamepc.reset()
            gamepc.p1 = 0
            gamepc.p2 = 0
            gamepc.ties = 0
            gamepc.round = 1
        }


        Grid {
            id: cell2
            anchors.verticalCenterOffset: 8
            anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                columns: 3
                spacing: 8

                Repeater {
                    id: row2
                       model: 9

                       delegate: Rectangle {

                           height: gamepc.height /3
                           width: gamepc.height /3
                           color: "white"

                            Image {
                               id: img
                               visible: true
                               height: gamepc.height * 0.3
                               width: parent.width * 0.9
                               anchors.centerIn: parent
                               source: ""
                               NumberAnimation{
                                   id: animateOpacity
                                   target: img
                                   property: "opacity"
                                   from: 0
                                   to: 1
                                   duration: 400

                               }
                               SequentialAnimation{
                                   id: pcAnimation
                                   PauseAnimation {
                                       duration: 500
                                   }
                                   NumberAnimation{
                                       target: img
                                       property: "opacity"
                                       from: 0
                                       to: 1
                                       duration: 400
                                   }
                               }
                           }
                           property var image: img
                           property var animate: pcAnimation

                           MouseArea{
                               anchors.fill: parent
                                onClicked: {
                                    if(_grid.atPos(index) == 0){
                                        //vez do jogador
                                            img.source = "images/x.png"
                                            animateOpacity.start()
                                            _grid.setValue(index, 1)
                                            gamepc.player = 2

                                         var aux =_grid.win()
                                       //vez do pc
                                         if(!_grid.isFull() && aux==0){

                                            gamepc.pcRound()
                                            aux =_grid.win()
                                         }
                                         //verifica se há vencedor
                                        if(aux != 0){
                                            line(row2)
                                            if(aux==1){
                                                gamepc.p1++
                                                messageDialog.show(qsTr("você ganhou!"))
                                            }
                                            else{
                                                messageDialog.show(qsTr("o pc ganhou!"))
                                                gamepc.p2++
                                            }
                                        }
                                        //verifica se é empate
                                        else if(_grid.isFull()){
                                            messageDialog.show("empate!")
                                            gamepc.ties++
                                        }
                                    }

                                }
                           }
                       }
                   }

               }

    }
    //destaca sequencia que deu velha
    function line(element){
        if(_grid.line() == 1){
            element.itemAt(0).color = "magenta"
            element.itemAt(1).color = "magenta"
            element.itemAt(2).color = "magenta"
        }
        else if(_grid.line() == 2){
            element.itemAt(3).color = "magenta"
            element.itemAt(4).color = "magenta"
            element.itemAt(5).color = "magenta"
        }
        else if(_grid.line() == 3){
            element.itemAt(6).color = "magenta"
            element.itemAt(7).color = "magenta"
            element.itemAt(8).color = "magenta"
        }
        else if(_grid.line() == 4){
            element.itemAt(0).color = "magenta"
            element.itemAt(3).color = "magenta"
            element.itemAt(6).color = "magenta"
        }
        else if(_grid.line() == 5){
            element.itemAt(1).color = "magenta"
            element.itemAt(4).color = "magenta"
            element.itemAt(7).color = "magenta"
        }
        else if(_grid.line() == 6){
            element.itemAt(2).color = "magenta"
            element.itemAt(5).color = "magenta"
            element.itemAt(8).color = "magenta"
        }
        else if(_grid.line() == 7){
            element.itemAt(0).color = "magenta"
            element.itemAt(4).color = "magenta"
            element.itemAt(8).color = "magenta"
        }
        else if(_grid.line() == 8){
            element.itemAt(2).color = "magenta"
            element.itemAt(4).color = "magenta"
            element.itemAt(6).color = "magenta"
        }
    }
    MessageDialog {
        id: messageDialog
        title: qsTr("Fim de jogo")
        standardButtons: StandardButton.Yes |  StandardButton.No
        onYes: {
            //reinicia o jogo
            mode.reset()
            mode.round++
        }
        onNo: {
            //volta ao menu
            mode.clear()
            mode.visible = false
            menu.visible = true
        }

        function show(caption) {
            messageDialog.text = caption + "\ncontinuar?";
            messageDialog.open();
        }
  }
    //marca os pontos
    Rectangle{
        id: status
        visible: mode.visible
        width: 300
        height: 60
        anchors.top: game.bottom
        anchors.horizontalCenter: game.horizontalCenter
        color: "transparent"
        Text {
            id: round            
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("rodada: "+mode.round+"\t")
            color: "yellow"
             font.bold: true
        }
        Text {
            id: player1
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: round.right
            text: qsTr("jogador 1: "+mode.p1+"\t")
            color: "yellow"
             font.bold: true
        }
        Text {
            id: ties
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: player1.right
            text: qsTr("empates: "+mode.ties+"\t")
            color: "yellow"
            font.bold: true
        }
        Text {
            id: player2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: ties.right
            text: qsTr("jogador 2: "+mode.p2+"\t")
            color: "yellow"
            font.bold: true
        }

    }
    Rectangle{
        id: button1
        visible: mode.visible
        x: page.width - 100
        y: page.height *0.02
        width: 70
        height: 30
        color: "#B388FF"
        radius: 10
        Text {
            anchors.centerIn: parent
            id: tx
            text: qsTr("voltar")
            color: "yellow"
            font.bold: true
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mode.clear()
                mode.visible = false
                menu.visible = true
            }
        }
    }
}
