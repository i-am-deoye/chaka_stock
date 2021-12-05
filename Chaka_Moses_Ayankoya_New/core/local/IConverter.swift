//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


protocol IEntityConvetable {
    func toEntity<E>() -> E?
}


protocol IModelConvertable {
    func toModel<M>() -> M?
}
