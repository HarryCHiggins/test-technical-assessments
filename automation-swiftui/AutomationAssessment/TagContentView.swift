//
//  TagContentView.swift
//  AutomationAssessment
//
//  Created by Nicholas Jones - Mobile iPlayer - Erbium on 29/10/2024.
//

import SwiftUI

struct TagContentView: View {
    let tag: Tag
    var body: some View {
        ScrollView {
            Text(
"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent congue efficitur lorem, sed sagittis enim interdum quis. Donec in turpis commodo urna sagittis mattis nec at leo. Vestibulum elit enim, maximus a ante non, dignissim bibendum sapien. Aliquam non commodo metus. Suspendisse dignissim pulvinar mollis. Aliquam erat volutpat. Duis sollicitudin imperdiet elit, ut placerat diam blandit quis. Nunc hendrerit turpis vitae pulvinar fringilla. Ut at pretium sapien. Nullam cursus sodales ante ut ultricies.\nUt felis libero, imperdiet a semper vel, sollicitudin sit amet massa. Duis sed rutrum dui. Aenean gravida quam ante, sit amet semper ipsum aliquam tempus. Integer vitae auctor mauris. Nulla tristique sed purus vel placerat. Vivamus laoreet sed enim at blandit. Fusce pharetra lorem vitae rutrum vulputate. Nulla nec nisi ut mi lacinia ornare blandit ac odio. faucibus ipsum egestas sit amet.

Phasellus rutrum ac nisl a porta. Sed eu tellus viverra, dapibus tortor in, ultrices odio. Sed eget felis vitae arcu gravida mattis sit amet eget ipsum. Proin eget nisi eget ante maximus euismod vel in est. Nunc at sem elementum, ullamcorper sapien nec, ultricies eros. Vivamus scelerisque blandit dolor, id pellentesque dolor.

Fusce id lacus orci. Vestibulum tristique euismod ante, id consequat augue semper sit amet. Praesent dictum ornare lorem vel vehicula. Fusce id dui tempor, sollicitudin tortor vel, commodo metus. Vestibulum ac ex at felis placerat ornare nec non nunc. Donec aliquet quam tortor, eu pellentesque lectus aliquet sed. Donec vitae elit lacus. Donec quis maximus orci. Quisque felis orci, mollis vitae ante consectetur, faucibus dictum massa. Vestibulum libero felis, luctus nec enim sed, volutpat lobortis sem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi scelerisque pretium viverra. Fusce suscipit lectus in orci aliquet, sed lacinia nulla rhoncus. Nunc efficitur scelerisque consectetur. Suspendisse vel convallis odio. Fusce porttitor orci nec mauris auctor, ut vestibulum mauris maximus.

Donec nec auctor ligula, ut pretium erat. Nunc massa tellus, molestie vitae risus porttitor, gravida pulvinar nisi. Aenean nec ex id ex malesuada faucibus a eget turpis. Sed sed erat leo. In hac habitasse platea dictumst. Vestibulum sagittis arcu eros, quis finibus nibh eleifend in. Integer diam ipsum, gravida fringilla sem eget, aliquet euismod augue. Fusce tincidunt leo nisi, quis interdum libero fermentum eget.

Aliquam euismod leo ac erat pellentesque tincidunt. Donec ullamcorper, tortor a blandit consequat, nibh sapien volutpat nisi, vel vestibulum ante lectus molestie massa. Sed blandit, diam eu congue fermentum, nunc lectus dictum metus, in semper ex sapien eget tortor. Donec porttitor egestas nisl, et placerat arcu consequat at. Etiam non aliquet metus. Nam nisl urna, mattis vitae finibus in, condimentum a magna. Sed rhoncus quam a lectus facilisis interdum. Curabitur auctor quam vitae egestas suscipit. Proin in nisi vel erat eleifend cursus. Pellentesque id egestas erat. Maecenas varius tempus purus blandit molestie. Quisque a risus sem. Etiam id ultricies augue, id iaculis odio. In non dolor et mi fermentum tempus. Suspendisse in tortor lacus. Proin purus metus, consequat eu est id, viverra efficitur orci.

Sed cursus auctor malesuada. Morbi in risus turpis. Duis quis molestie neque. Praesent cursus sem nec viverra euismod. Proin ut imperdiet lectus. Nulla iaculis lobortis elit, quis ultricies felis aliquet nec. Nullam ac urna rutrum, feugiat orci ut, elementum enim. Vivamus aliquam id tortor nec ultricies. Etiam dictum velit at porttitor faucibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas tempor est quis tellus dapibus, ut maximus sapien dictum. Nunc ut est lacinia ligula interdum gravida a at velit. Nam sit amet tempor nisi.

Fusce in dolor commodo, pharetra libero nec, vulputate libero. Curabitur bibendum dolor sit amet enim convallis imperdiet. Integer euismod velit non est faucibus porta. Aenean vulputate commodo justo ut egestas. Cras tempor diam et ante aliquet, sed efficitur velit aliquam. Cras et odio lorem. Donec porttitor sit amet nulla non dictum.

Vivamus quis posuere turpis. Duis ultrices dignissim laoreet. Nunc suscipit id nunc sed finibus. Nunc eleifend ante odio, vitae posuere nibh condimentum venenatis. Phasellus felis leo, scelerisque et massa a, vehicula ultricies dui. Proin hendrerit purus vel nisi varius placerat. Quisque quis ultrices neque. Fusce viverra aliquet arcu, ut porta massa laoreet eu. Praesent magna metus, fermentum ut sem sed, lacinia congue urna. Cras pulvinar vel diam a lacinia. Phasellus efficitur pellentesque eros lobortis pulvinar. Nullam quis aliquam ipsum.

Proin sollicitudin nisl vitae diam tristique consequat. Fusce sagittis ac dolor a faucibus. Fusce laoreet, massa et bibendum tempus, libero augue tempus neque, ac mattis neque libero at mauris. Cras nulla ipsum, tempus nec sem vel, rhoncus aliquet metus. Pellentesque vestibulum feugiat magna eget convallis. Quisque eget sollicitudin eros. Integer euismod nunc vitae ultricies tempus.

This is the end of the placeholder text.
"""
            )
            .accessibilityIdentifier(AutomationIdentifiers.contentText.rawValue)
            .padding()
        }
        .navigationTitle(tag.title)
    }
}

#Preview {
    NavigationStack {
        TagContentView(tag: .politics)
    }
}
