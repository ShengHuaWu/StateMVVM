//
//  Reducer.swift
//  StateMVVM
//
//  Created by ShengHua Wu on 16.01.19.
//  Copyright © 2019 ShengHua Wu. All rights reserved.
//

struct Reducer<Event, State> {
    let run: (Event, @escaping (State) -> Void) -> Void
}
