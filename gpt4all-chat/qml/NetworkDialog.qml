import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import download
import network
import llm
import mysettings

MyDialog {
    id: networkDialog
    anchors.centerIn: parent
    modal: true
    padding: 20

    Theme {
        id: theme
    }

    Column {
        id: column
        spacing: 20
        Item {
            width: childrenRect.width
            height: childrenRect.height
            Image {
                id: img
                anchors.top: parent.top
                anchors.left: parent.left
                width: 60
                height: 60
                source: "qrc:/gpt4all/icons/logo.svg"
            }
            Text {
                anchors.left: img.right
                anchors.leftMargin: 30
                anchors.verticalCenter: img.verticalCenter
                text: qsTr("GPT4All Opensource 기반으로 유콘크리에이티브 테스트용 제작")
                color: theme.textColor
                font.pixelSize: theme.fontSizeLarge
            }
        }

        ScrollView {
            clip: true
            height: 300
            width: 1024 - 40
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            MyTextArea {
                id: textOptIn
                width: 1024 - 40
                text: qsTr("이 기능을 활성화하면 향후 모델 개선을 위한 데이터를 제공하여 대규모 언어 모델을 훈련하는 민주적 프로세스에 참여할 수 있습니다.

GPT4All 모델이 귀하에게 응답하고 귀하가 동의하면 대화가 GPT4All 오픈 소스 데이터레이크로 전송됩니다. 또한 응답에 좋아요/싫어요를 설정할 수 있습니다. 답변이 마음에 들지 않으면 대체 답변을 제안할 수 있습니다. 이 데이터는 GPT4All Datalake에서 수집되고 집계됩니다.

참고: 이 기능을 켜면 데이터가 GPT4All 오픈 소스 데이터레이크로 전송됩니다. 이 기능을 활성화하면 채팅 개인 정보 보호를 기대할 수 없습니다. 당신은해야합니다; 그러나 원하는 경우 선택적 귀속을 기대할 수 있습니다. 귀하의 채팅 데이터는 누구나 다운로드할 수 있도록 공개적으로 제공되며 Nomic AI가 향후 GPT4All 모델을 개선하는 데 사용될 것입니다. Nomic AI는 귀하의 데이터에 첨부된 모든 속성 정보를 유지하며 귀하는 귀하의 데이터를 사용하는 모든 GPT4All 모델 릴리스에 기여자로 인정됩니다!")
                focus: false
                readOnly: true
                Accessible.role: Accessible.Paragraph
                Accessible.name: qsTr("Terms for opt-in")
                Accessible.description: qsTr("Describes what will happen when you opt-in")
            }
        }

        MyTextField {
            id: attribution
            width: parent.width
            text: MySettings.networkAttribution
            placeholderText: qsTr("Please provide a name for attribution (optional)")
            Accessible.role: Accessible.EditableText
            Accessible.name: qsTr("Attribution (optional)")
            Accessible.description: qsTr("Provide attribution")
            onEditingFinished: {
                MySettings.networkAttribution = attribution.text;
            }
        }
    }

    footer: DialogButtonBox {
        id: dialogBox
        padding: 20
        alignment: Qt.AlignRight
        spacing: 10
        MySettingsButton {
            text: qsTr("Enable")
            Accessible.description: qsTr("Enable opt-in")
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        MySettingsButton {
            text: qsTr("Cancel")
            Accessible.description: qsTr("Cancel opt-in")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
        background: Rectangle {
            color: "transparent"
        }
    }

    onAccepted: {
        if (MySettings.networkIsActive)
            return
        MySettings.networkIsActive = true;
        Network.sendNetworkToggled(true);
    }

    onRejected: {
        if (!MySettings.networkIsActive)
            return
        MySettings.networkIsActive = false;
        Network.sendNetworkToggled(false);
    }
}
