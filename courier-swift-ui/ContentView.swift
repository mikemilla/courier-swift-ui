//
//  ContentView.swift
//  courier-swift-ui
//
//  Created by Michael Miller on 12/9/24.
//

import SwiftUI
import Courier_iOS

struct ContentView: View {
    
    func getTheme() -> CourierInboxTheme {
        let whiteColor = UIColor.white
        let blackColor = UIColor.black
        let blackLightColor = UIColor.black.withAlphaComponent(0.5)
        let primaryColor = UIColor(red: 102/255, green: 80/255, blue: 164/255, alpha: 1)
        let primaryLightColor = UIColor(red: 98/255, green: 91/255, blue: 113/255, alpha: 1)
        let font = UIFont(name: "Avenir-Medium", size: 18)

        return CourierInboxTheme(
            tabIndicatorColor: primaryColor,
            tabStyle: CourierStyles.Inbox.TabStyle(
                selected: CourierStyles.Inbox.TabItemStyle(
                    font: CourierStyles.Font(
                        font: font!,
                        color: primaryColor
                    ),
                    indicator: CourierStyles.Inbox.TabIndicatorStyle(
                        font: CourierStyles.Font(
                            font: font!,
                            color: whiteColor
                        ),
                        color: primaryColor
                    )
                ),
                unselected: CourierStyles.Inbox.TabItemStyle(
                    font: CourierStyles.Font(
                        font: font!,
                        color: blackLightColor
                    ),
                    indicator: CourierStyles.Inbox.TabIndicatorStyle(
                        font: CourierStyles.Font(
                            font: font!,
                            color: whiteColor
                        ),
                        color: blackLightColor
                    )
                )
            ),
            readingSwipeActionStyle: CourierStyles.Inbox.ReadingSwipeActionStyle(
                read: CourierStyles.Inbox.SwipeActionStyle(
                    icon: UIImage(systemName: "envelope.open.fill"),
                    color: primaryColor
                ),
                unread: CourierStyles.Inbox.SwipeActionStyle(
                    icon: UIImage(systemName: "envelope.fill"),
                    color: primaryLightColor
                )
            ),
            archivingSwipeActionStyle: CourierStyles.Inbox.ArchivingSwipeActionStyle(
                archive: CourierStyles.Inbox.SwipeActionStyle(
                    icon: UIImage(systemName: "archivebox.fill"),
                    color: primaryColor
                )
            ),
            unreadIndicatorStyle: CourierStyles.Inbox.UnreadIndicatorStyle(
                indicator: .dot,
                color: primaryColor
            ),
            titleStyle: CourierStyles.Inbox.TextStyle(
                unread: CourierStyles.Font(
                    font: font!,
                    color: blackColor
                ),
                read: CourierStyles.Font(
                    font: font!,
                    color: blackColor
                )
            ),
            timeStyle: CourierStyles.Inbox.TextStyle(
                unread: CourierStyles.Font(
                    font: font!,
                    color: blackColor
                ),
                read: CourierStyles.Font(
                    font: font!,
                    color: blackColor
                )
            ),
            bodyStyle: CourierStyles.Inbox.TextStyle(
                unread: CourierStyles.Font(
                    font: font!,
                    color: blackLightColor
                ),
                read: CourierStyles.Font(
                    font: font!,
                    color: blackLightColor
                )
            ),
            buttonStyle: CourierStyles.Inbox.ButtonStyle(
                unread: CourierStyles.Button(
                    font: CourierStyles.Font(
                        font: font!,
                        color: whiteColor
                    ),
                    backgroundColor: primaryColor,
                    cornerRadius: 100
                ),
                read: CourierStyles.Button(
                    font: CourierStyles.Font(
                        font: font!,
                        color: whiteColor
                    ),
                    backgroundColor: primaryColor,
                    cornerRadius: 100
                )
            ),
            cellStyle: CourierStyles.Cell(
                separatorStyle: .singleLine,
                separatorInsets: .zero
            ),
            infoViewStyle: CourierStyles.InfoViewStyle(
                font: CourierStyles.Font(
                    font: font!,
                    color: blackColor
                ),
                button: CourierStyles.Button(
                    font: CourierStyles.Font(
                        font: font!,
                        color: whiteColor
                    ),
                    backgroundColor: primaryColor,
                    cornerRadius: 100
                )
            )
        )
    }
    
    var body: some View {
        CourierInboxView(
            canSwipePages: false,
            lightTheme: getTheme(),
            darkTheme: getTheme(),
            didClickInboxMessageAtIndex: { message, index in
                message.isRead ? message.markAsUnread() : message.markAsRead()
                print(index, message)
            },
            didLongPressInboxMessageAtIndex: { message, index in
                message.markAsArchived()
                print(index, message)
            },
            didClickInboxActionForMessageAtIndex: { action, message, index in
                print(action, message, index)
            },
            didScrollInbox: { scrollView in
                print(scrollView.contentOffset.y)
            }
        )
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        Task {
            let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6InVzZXJfaWQ6dXNlcl8xMDkgd3JpdGU6dXNlci10b2tlbnMgaW5ib3g6cmVhZDptZXNzYWdlcyBpbmJveDp3cml0ZTpldmVudHMgcmVhZDpwcmVmZXJlbmNlcyB3cml0ZTpwcmVmZXJlbmNlcyByZWFkOmJyYW5kcyIsInRlbmFudF9zY29wZSI6InB1Ymxpc2hlZC9wcm9kdWN0aW9uIiwidGVuYW50X2lkIjoiNmE1MWJmOGMtYWQyZS00MmJmLWJlNmEtODM4NWI1ZDRhMGY1IiwiaWF0IjoxNzM4OTQ4ODU2LCJleHAiOjE4MjUzNDg4NTYsImp0aSI6ImVkODg1N2Q3LTYzMmQtNDI5OS1iNGUwLTk1ZWVlYWQ0ZjY5NCJ9.ZxHiOxwBuzBI_sMP0pcpcBteZge0grmQ1YHa8ONX3Uo"
            await Courier.shared.signIn(userId: "user_109", accessToken: jwt)
        }
    }
    
}

#Preview {
    ContentView()
}
