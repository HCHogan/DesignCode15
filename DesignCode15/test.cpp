//
//  test.cpp
//  DesignCode15
//
//  Created by Hank Hogan on 2023/11/22.
//

#include "test.hpp"
#include <iostream>
#include <ranges>

namespace ranges = std::ranges;
namespace views = std::views;

using std::cout;

int test() {
    for(auto&& [i, c] : ranges::zip_view(views::iota(1), views::iota(2))
            | views::drop(1)
            | views::take(5)
            | views::reverse) {
        cout << i << c << '\n';
    }
    return 0;
}
