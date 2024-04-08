import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import download
import network
import llm

MyDialog {
    id: dalleDialog
    anchors.centerIn: parent
    modal: false
    padding: 20
    width: 1024
    height: column.height + 40

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
                source: "qrc:/gpt4all/icons/dalle.svg"
            }
            Text {
                anchors.left: img.right
                anchors.leftMargin: 120
                anchors.verticalCenter: img.verticalCenter
                text: qsTr("달리 E 테스트")
                color: theme.textColor
                font.pixelSize: theme.fontSizeLarge
                font.bold: true
            }
        }

        ScrollView {
            clip: true
            height: 200
            width: 800 - 40
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            MyTextArea {
                id: welcome
                width: 800 - 40
                textFormat: TextEdit.MarkdownText
                text: qsTr("테스트 ui 넣어야함.\n")
                    + Download.releaseInfo.notes
                    + qsTr("나중에 추가할 예정\n")
                    + Download.releaseInfo.contributors
                focus: false
                readOnly: true
                Accessible.role: Accessible.Paragraph
                Accessible.name: qsTr("Release notes")
                Accessible.description: qsTr("Release notes for this version")
            }
        }

        MySettingsLabel {
            id: discordLink
            width: parent.width
            textFormat: Text.StyledText
            wrapMode: Text.WordWrap
            text: qsTr("유콘크리에이티브 <a href=\"https://uconcreative.com/>https://uconcreative.com</a>")
            font.pixelSize: theme.fontSizeLarge
            onLinkActivated: { Qt.openUrlExternally("https://discord.gg/4M2QFmTt2k") }
            color: theme.textColor
            linkColor: theme.linkColor

            Accessible.role: Accessible.Link
            Accessible.name: qsTr("Discord link")
        }

        MySettingsLabel {
            id: nomicProps
            width: parent.width
            textFormat: Text.StyledText
            wrapMode: Text.WordWrap
            text: qsTr("달리. <a href=\"https://home.nomic.ai\">DAll-e.")
            font.pixelSize: theme.fontSizeLarge
            onLinkActivated: { Qt.openUrlExternally("https://uconcreative.com/") }
            color: theme.textColor
            linkColor: theme.linkColor

            Accessible.role: Accessible.Paragraph
            Accessible.name: qsTr("Thank you blurb")
            Accessible.description: qsTr("Contains embedded link to https://home.nomic.ai")
        }
    }

    MyButton {
        id: checkForUpdatesButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: qsTr("이미지 생성")
        font.pixelSize: theme.fontSizeLarge
        Accessible.description: qsTr("Launch an external application that will check for updates to the installer")
        onClicked: {
            if (!LLM.checkForUpdates())
                checkForUpdatesError.open()
        }
    }
}
