import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "multipleselectionlistview.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("Multiple Selection ListView")

        ListModel {
            id: fruitModel

            ListElement {
                name: "apple"
                cost: 2.45
            }
            ListElement {
                name: "orange"
                cost: 3.25
            }
            ListElement {
                name: "banana"
                cost: 1.95
            }
            ListElement {
                name: "grape"
                cost: 4.95
            }
        }

        MultipleSelectionListView {
            id: view
            clip: true
            anchors.fill: parent
            listModel: fruitModel

            listDelegate: Rectangle {
                id: delegate
                width: view.width
                height: units.gu(10)


                Image {
                    id: fruit
                    height: units.gu(8)
                    width: height
                    source: "images/" + name + ".jpg"
                }

                Text {
                    anchors.left: fruit.right
                    anchors.leftMargin: units.gu(10)
                    anchors.verticalCenter: parent.verticalCenter
                    text: "$" + cost
                }

                Image {
                    anchors.right: parent.right
                    anchors.rightMargin: units.gu(1)
                    anchors.verticalCenter: parent.verticalCenter
                    height: units.gu(4)
                    width: height
                    source: "images/tick.png"
                    visible: view.isSelected(delegate)
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (view.isInSelectionMode) {
                            if ( view.isSelected(delegate))
                                view.deselectItem(delegate)
                            else
                                view.selectItem(delegate)
                        }
                    }
                    onPressAndHold: {
                        console.log("start to select....");
                        view.startSelection()
                    }
                }
            }
            onSelectionDone: console.debug("Selected items:" + view.selectedItems)
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(1)
            spacing: units.gu(1)

            Button {
                text: view.isInSelectionMode ? "Stop selection" : "Start selection"

                onClicked: {
                    if ( view.isInSelectionMode ) {
                        view.endSelection();
                    } else  {
                        view.startSelection();
                    }
                }
            }

            Button {
                text: "Cancel selection"

                onClicked: {
                    view.cancelSelection();
                }
            }

            Button {
                text: "Select all"
                onClicked: {
                    view.selectAll();
                }
            }

            Button {
                text: "Get Selection"
                onClicked: {
                    console.log("Selected items are:");

                    var count = view.selectedItems.count;
                    console.log("count: " + count);

                    for ( var i = 0; i < count; i ++ ) {
                        var item = view.selectedItems.get(i);
                        console.log("item: " + item);
                        console.log("item.model: " + item.model);
                        console.log("item.model.name: " + item.model.name);
                        console.log("item.model.index: " + item.model.index);
                        console.log("item.inSelected: " + item.inSelected);
                    }
                }
            }
        }
    }
}

