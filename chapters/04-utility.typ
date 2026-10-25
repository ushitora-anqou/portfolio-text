#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, term-meta
#import "@preview/cetz:0.5.2"

= 効用とリスク回避

投資家は確定していない将来の富をどのように評価して選択するのだろうか。この章では、不確実な状況での選択を表現する効用関数を導入し、リスクを嫌う傾向を凹性として定式化する。そして、投資家の選好が収益率の期待値と分散という二つの量で表せる条件を整える。この条件の下で、次章以降のポートフォリオ分析が展開される。

== 選好と効用関数

=== 効用関数

投資の結果として得られる金額を $x$ と書く。投資家は金額の間に「$x$ は $y$ 以上に望ましい」という二項関係を持つ。この関係が矛盾なく整理できているとき、望ましさを数値に置き換えて扱える。

#definition[
  金額の集合上の実数値関数 $u$ が、任意の金額 $x, y$ に対して、$x$ が $y$ 以上に望ましいことと
  $ u(x) >= u(y) $
  が成り立つことが同値であるとき、$u$ を投資家の#term-meta((kana: "こうようかんすう", ja: "効用関数", en: "utility function"))#strong[効用関数]（utility function）と呼ぶ。
]

効用関数は望ましさの順序を保つ一種の物差しである。効用関数の値そのものに経済的な意味はない。順序を保存する任意の正の倍率や変換に対して、選択の予測は変わらない。本書では効用関数は金額について増加する、すなわち多い金額ほど効用が高いと考える。

#definition[
  任意の $x < y$ に対して $u(x) < u(y)$ が成り立つとき、$u$ は#term-meta((kana: "ぞうかかんすう", ja: "増加関数", en: "increasing function"))#strong[増加関数]（increasing function）であると言う。本書では効用関数は増加関数であると仮定する。
]

=== 期待効用仮説

結果が確定していない選択肢、たとえば「確率 $1\/2$ で $100$ 万円、確率 $1\/2$ で $0$ 円」を#term-meta((kana: "くじ", ja: "くじ", en: "lottery"))#strong[くじ]（lottery）と呼ぶ。くじに対する選好がどのような効用で表されるかは自明ではない。金額の期待値の効用 $u(E[X])$ で評価するという考え方もある。しかし、後で見るように、この評価方法ではリスクを嫌う行動を表せない。

フォン・ノイマン（John von Neumann）とモルゲンシュテルン（Oskar Morgenstern）は、くじに対する選好が特定の公理系を満たすとき、選好が期待値 $E[u(X)]$ の順序で表されることを示した @vonneumann1947。公理系の内容は、選好の完全性、推移性、連続性、そして確率の混合に関する独立性である。

#theorem[
  （フォン・ノイマンとモルゲンシュテルンによる期待効用表現）くじに対する選好が完全性、推移性、連続性、独立性の公理を満たすとき、効用関数 $u$ が存在して、くじ $X$ と $Y$ に対して、$X$ が選好されることは
  $ E[u(X)] >= E[u(Y)] $ <eq-vnm>
  と同値である。
]<thm-vnm>

この定理の証明は付録Cで与える。公理系の精密な定式化から始めて、存在と一意性をすべて示す。本書ではこの表現定理を#term-meta((kana: "きたいこうようかせつ", ja: "期待効用仮説", en: "expected utility hypothesis"))#strong[期待効用仮説]（expected utility hypothesis）として採用する。すなわち、投資家はくじを金額の効用の期待値 $E[u(X)]$ によって評価すると考える。

期待効用仮説の下では、金額の期待値そのものではなく、効用の期待値が選択の基準になる。この違いが、リスクに対する態度を表現する入口になる。

== リスク回避

同じ期待値を持つ二つの選択肢を比べる。一つは確実に期待値の金額を受け取る選択肢、もう一つは期待値の周りにばらつく金額を受け取るくじである。多くの投資家は前者を選ぶ。この傾向を効用関数の凹性として表現する。

#definition[
  任意の金額 $x, y$ と $0 <= lambda <= 1$ に対して
  $ u(lambda x + (1 - lambda) y) >= lambda u(x) + (1 - lambda) u(y) $ <eq-concave>
  が成り立つとき、$u$ は#term-meta((kana: "おう", ja: "凹", en: "concave"))#strong[凹]（concave）である、または#strong[凹関数]（concave function）であると言う。すべての $x != y$ と $0 < lambda < 1$ で等号が成り立たないとき、$u$ は#strong[厳密に凹]（strictly concave）であると言う。
]<def-concave>

凹性の不等式は、二つの金額の中間地点の効用が、それぞれの効用の中間以上にあることを述べている。図式的に言えば、関数のグラフが弧を描いて結ばれていることを意味する。@fig-concave は、$lambda = 1\/2$ の場合のこの関係を示したものである。次の定理は凹性とリスク回避の関係を正確に述べる。

#figure(
  cetz.canvas(length: 1.4cm, {
    import cetz.draw: *
    let f(x) = calc.sqrt(x)
    let pts = ()
    let n = 48
    for i in range(0, n + 1) {
      let x = i / n * 4
      pts.push((x, f(x)))
    }
    line((0, 0), (4.6, 0), stroke: 0.7pt + black)
    line((0, 0), (0, 2.5), stroke: 0.7pt + black)
    content((4.75, 0), [$x$], anchor: "west")
    content((0, 2.65), [$u(x)$], anchor: "south")
    line(..pts, stroke: 1pt + black)
    let x1 = 0.5
    let x2 = 4.0
    line((x1, f(x1)), (x2, f(x2)), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
    let xm = (x1 + x2) / 2
    let ychord = (f(x1) + f(x2)) / 2
    circle((xm, ychord), radius: 0.04, fill: black)
    circle((xm, f(xm)), radius: 0.04, fill: black)
    line((x1, 0), (x1, f(x1)), stroke: 0.4pt + gray, dash: "dotted")
    line((x2, 0), (x2, f(x2)), stroke: 0.4pt + gray, dash: "dotted")
    line((xm, 0), (xm, f(xm)), stroke: 0.4pt + gray, dash: "dotted")
    content((x1, -0.18), [$x_1$], anchor: "north")
    content((x2, -0.18), [$x_2$], anchor: "north")
    content((xm, -0.18), [$frac(x_1 + x_2, 2)$], anchor: "north")
    content((2.5, 1.1), [$frac(u(x_1) + u(x_2), 2)$], anchor: "north-west")
    line((2.46, 1.16), (2.32, 1.31), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((xm, f(xm) + 0.35), [$u(frac(x_1 + x_2, 2))$], anchor: "south")
    line((xm, f(xm) + 0.32), (xm, f(xm) + 0.07), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
  }),
  caption: [凹な効用関数の中間地点の効用は、効用の中間以上にある],
  supplement: [図],
)<fig-concave>

#theorem[
  効用関数 $u$ が凹であることと、任意の確率変数 $X$ に対して
  $ u(E[X]) >= E[u(X)] $ <eq-jensen>
  が成り立つことは同値である。この不等式を#term-meta((kana: "いぇんせんのふとうしき", ja: "イェンセンの不等式", en: "Jensen's inequality"))#strong[イェンセンの不等式]（Jensen's inequality）と呼ぶ。密度関数を持つ $X$ に対しても成り立つことが、確率論の標準的な結果として知られている。
]<thm-jensen>

#proof[
  （凹なら不等式が成り立つこと）$X$ が二つの値 $x_1, x_2$ を確率 $lambda$ と $1 - lambda$ でとるとき、$E[X] = lambda x_1 + (1 - lambda) x_2$ である。@def-concave の不等式を適用すると
  $ u(E[X]) = u(lambda x_1 + (1 - lambda) x_2) >= lambda u(x_1) + (1 - lambda) u(x_2) = E[u(X)] $
  となり、$X$ が二値のときは示された。

  $X$ が $n$ 個の値 $x_1, ..., x_n$ を確率 $p_1, ..., p_n >= 0$、$sum p_i = 1$ でとるときを帰納法で示す。$n = 1$ のとき $X$ は定数なので両辺は等しい。$n$ 個まで示されていると仮定し、$n + 1$ 個の場合を考える。$p_(n+1) = 1$ なら $X$ は定数であり自明である。$p_(n+1) < 1$ とすると
  $ E[X] = (1 - p_(n+1)) m + p_(n+1) x_(n+1), quad m = sum_(i=1)^n (p_i / (1 - p_(n+1))) x_i $
  と書ける。$m$ は重み $p_i\/(1 - p_(n+1))$ の和が $1$ である $x_1, ..., x_n$ の重み付き平均である。凹性の定義を $x = m$、$y = x_(n+1)$、$lambda = 1 - p_(n+1)$ として適用すると
  $ u(E[X]) >= (1 - p_(n+1)) u(m) + p_(n+1) u(x_(n+1)) $
  となる。ここで $m$ は $n$ 個の値の重み付き平均だから、帰納法の仮定を金額 $m$ の分布に適用すると $u(m) >= sum_(i=1)^n (p_i / (1 - p_(n+1))) u(x_i)$ である。これを代入して整理すると
  $ u(E[X]) >= sum_(i=1)^n p_i u(x_i) + p_(n+1) u(x_(n+1)) = E[u(X)] $
  が得られる。帰納法により、有限個の値をとる任意の $X$ で不等式が成り立つ。

  （不等式が成り立つなら凹であること）任意の $x, y$ と $lambda in [0, 1]$ に対し、$X$ を確率 $lambda$ で $x$、確率 $1 - lambda$ で $y$ をとる確率変数とする。このとき $E[X] = lambda x + (1 - lambda) y$ なので、仮定の不等式は @def-concave の不等式そのものになる。
]

#definition[
  効用関数が凹である投資家を#term-meta((kana: "りすくかいひてき", ja: "リスク回避的", en: "risk-averse"))#strong[リスク回避的]（risk-averse）であると呼ぶ。実数 $a > 0$ と $b$ によって $u(x) = a x + b$ と書けるとき $u$ は#term-meta((kana: "ちょくせん", ja: "直線", en: "linear"))#strong[直線]であると言い、直線の効用関数を持つ投資家を#strong[リスク中立的]（risk-neutral）と呼ぶ。$-u$ が凹であるとき $u$ は#strong[凸]（convex）であると言い、凸である投資家を#strong[リスク愛好的]（risk-seeking）と呼ぶ。
]

@thm-jensen はリスク回避的な投資家にとって、確率変数 $X$ よりも、その期待値 $E[X]$ を確実に受け取る方が望ましいことを意味する。実際、$u(E[X]) >= E[u(X)]$ であり、効用関数は増加関数だから、確実な金額 $E[X]$ の効用がくじの期待効用以上になる。多くの投資家の行動を説明するには凹な効用関数が適している。

#definition[
  確率変数 $X$ に対して、$E[u(X)] = u(E[X] - pi)$ を満たす金額 $pi$ を#term-meta((kana: "りすくぷれみあむ", ja: "リスクプレミアム", en: "risk premium"))#strong[リスクプレミアム]（risk premium）と呼ぶ。$u$ が増加関数であれば $pi$ は一意に定まり、$u$ が凹であれば $pi >= 0$ である。
]<def-risk-premium>

リスクプレミアムは、投資家がくじのばらつきを除去するために支払ってもよいと考える金額である。ばらつきが大きいほど、またリスク回避の度合いが強いほど、リスクプレミアムは大きくなる。これと表裏をなす量として、くじ $X$ と同じ期待効用を持つ確実な金額 $E[X] - pi$ を#term-meta((kana: "かくじつせいとうか", ja: "確実性等価", en: "certainty equivalent"))#strong[確実性等価]（certainty equivalent）と呼ぶ。くじの価値を確実な金額に換算したものであり、リスクプレミアムはくじの期待値と確実性等価の差に等しい。

#example[
  金額の単位を万円として、効用関数 $u(x) = sqrt(x)$ を考える。この関数が中点で凹であることは
  $ (sqrt(x) - sqrt(y))^2 >= 0 quad <=> quad sqrt((x + y)\/2) >= (sqrt(x) + sqrt(y))\/2 $
  として確認できる。確率 $1\/2$ で $0$ 万円、確率 $1\/2$ で $10$ 万円が当たるくじ $X$ をこの投資家が評価すると、
  $ E[X] = 5, quad E[u(X)] = 1\/2 dot.c 0 + 1\/2 dot.c sqrt(10) tilde.op 1.58, quad u(E[X]) = sqrt(5) tilde.op 2.24 $
  であり、@thm-jensen の不等式 $u(E[X]) >= E[u(X)]$ が具体的な数値として成り立っている。リスクプレミアム $pi$ は $u(5 - pi) = sqrt(10)\/2$ を満たすので $5 - pi = 10\/4 = 2.5$、すなわち $pi = 2.5$ 万円である。この投資家にとって、くじのばらつきは 2.5 万円の確実な金額に等しい。@fig-premium はこの関係を表したものである。
]<ex-lottery>

#figure(
  cetz.canvas(length: 0.65cm, {
    import cetz.draw: *
    let f(x) = calc.sqrt(x)
    let pts = ()
    let n = 48
    for i in range(0, n + 1) {
      let x = i / n * 10
      pts.push((x, f(x)))
    }
    line((0, 0), (10.6, 0), stroke: 0.7pt + black)
    line((0, 0), (0, 3.6), stroke: 0.7pt + black)
    content((10.75, 0), [$x$ (万円)], anchor: "west")
    content((0, 3.75), [$u(x)$], anchor: "south")
    line(..pts, stroke: 1pt + black)
    // chord between 0 and 10
    line((0, 0), (10, calc.sqrt(10)), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
    circle((5, calc.sqrt(10) / 2), radius: 0.07, fill: black)
    circle((5, calc.sqrt(5)), radius: 0.07, fill: black)
    circle((2.5, calc.sqrt(2.5)), radius: 0.07, fill: black)
    line((5, calc.sqrt(10) / 2), (2.5, calc.sqrt(2.5)), stroke: 0.5pt + gray)
    line((5, 0), (5, calc.sqrt(5)), stroke: 0.4pt + gray, dash: "dotted")
    line((2.5, 0), (2.5, calc.sqrt(2.5)), stroke: 0.4pt + gray, dash: "dotted")
    line((10, 0), (10, calc.sqrt(10)), stroke: 0.4pt + gray, dash: "dotted")
    content((5, -0.24), [$E[X]$], anchor: "north")
    content((2.5, -0.24), [$E[X] - pi$], anchor: "north")
    content((10, -0.24), [$10$], anchor: "north")
    content((6.3, 1.0), [$E[u(X)]$], anchor: "west")
    line((6.22, 1.1), (5.18, 1.5), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((6.0, 3.2), [$u(E[X])$], anchor: "west")
    line((5.9, 3.1), (5.15, 2.42), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((3.2, 2.2), [$u(E[X] - pi)$], anchor: "east")
    line((3.0, 1.85), (2.6, 1.7), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
  }),
  caption: [くじのリスクプレミアム：$E[u(X)]$ と $u(E[X] - pi)$ が一致する],
  supplement: [図],
)<fig-premium>

== 平均と分散による選好

この節の目的は、この章の締めくくりとして @axiom-ms で採用する平均と分散による選好の仮定を整えることである。そのための材料が、効用関数の形を限った場合の計算（@lem-quadratic-utility）と、分布の形を限った場合の観察（@def-normal のあとの説明）の二つである。両方を確認したのち、@axiom-ms として仮定を採用する。本章以降で投資の対象になる量は#term-meta((kana: "しゅうえきりつ", ja: "収益率", en: "rate of return"))#strong[収益率]（rate of return）、すなわち投資した金額に対する増加額の割合であり、厳密な定義は第 5 章で与える。ここでは金額の代わりに収益率を確率変数 $X$ として読み替えても、効用と期待効用の議論はそのまま成り立つ。

=== 効用の期待値を二つの量で書く条件

期待効用 $E[u(X)]$ は、一般には $X$ の分布全体に依存する。この節では、効用関数を2次式に限った場合と、分布を正規分布に限った場合の二つの場合に、期待効用が期待値 $mu = E[X]$ と分散 $sigma^2 = V[X]$ の二つの量だけで書けることを計算で確認する。

第一の場合は、効用関数が2次式である場合である。$u(x) = x - (b\/2) x^2$（$b > 0$）の形の効用関数を#term-meta((kana: "にじこうようかんすう", ja: "2次効用関数", en: "quadratic utility function"))#strong[2次効用関数]（quadratic utility function）と呼ぶ。

#lemma[
  $u(x) = x - (b\/2) x^2$（$b > 0$）とし、$X$ を $X < 1\/b$ を満たす確率変数とする。このとき
  $ E[u(X)] = E[X] - (b\/2) (E[X^2]) = mu - (b\/2) (mu^2 + sigma^2) $ <eq-quadratic-utility>
  ただし $mu = E[X]$、$sigma^2 = V[X]$ である。
]<lem-quadratic-utility>

#proof[
  @thm-linear により
  $ E[u(X)] = E[X - (b\/2) X^2] = E[X] - (b\/2) E[X^2] $
  である。@lem-var-alt と同じ方法で $E[X^2] = V[X] + (E[X])^2 = sigma^2 + mu^2$ なので、これを代入すると主張の等式が得られる。
]

2次効用には金額がある値を超えると効用が減少するという不自然な点がある。$X < 1\/b$ の制限はこの不自然さが現れない範囲を指定している。収益率の分布が大きくならない短期の投資では、この範囲の仮定は妥当と考えられる。

第二の条件は、$X$ が @def-normal の正規分布に従う場合である。正規分布の期待値は $mu$、分散は $sigma^2$ であり、分布の形はこの二つの量だけで決まる。したがって任意の関数の期待値は $mu$ と $sigma$ のみに依存し、この観察と期待効用仮説を合わせると、$X$ が正規分布に従う場合、投資家の評価 $E[u(X)]$ は $mu$ と $sigma$ のみの関数になる。効用関数の形によらず、平均と分散が同じ分布は同じ評価を受ける。

収益率の分布を正規分布で近似することは、@rem-clt とその後の説明の通り、中心的極限定理によって正当化される。

=== 本書で使う選好の仮定

以上の準備の下で、本書のあとの章で使う投資家の行動仮定を明示する。期待効用が $mu$ と $sigma^2$ で書ける状況、すなわち2次効用または正規分布のいずれかの条件の下では、$mu$ と $sigma$ に関する次の単調性が成り立つ。

#axiom[
  （平均分散選好の単調性）投資家の選好は、ポートフォリオの期待収益率 $mu$ と標準偏差 $sigma$ によって表され、次を満たす。
  + $sigma$ が等しければ、$mu$ の大きい方を選好する。
  + $mu$ が等しければ、$sigma$ の小さい方を選好する。
]<axiom-ms>

この公理を仮定として採用する背景には、これまでに見た二つの計算がある。@lem-quadratic-utility の @eq-quadratic-utility の右辺は $mu$ について増加し $sigma^2$ について減少する。また正規分布の場合も、期待効用が $mu$ と $sigma$ のみの関数になるとき、効用の増加性から $mu$ が大きいほど評価が高く、凹性から $sigma$ が大きいほど評価が低くなる。つまり、2次効用関数または正規分布のいずれかの条件の下では、この公理の二つの単調性は期待効用の仮定から説明がつく。本書では、この説明を離れて、単調性そのものを公理として採用する。

本書の残りの部分はこの公理だけを出発点とする。効用関数の特定の形も、分布の特定の形も、これ以上仮定しない。この意味で、のちの章で示すポートフォリオの最適性の結果は、平均分散選好の単調性という弱い仮定の上に立っている。

== 安全資産

ポートフォリオの選択肢には、分散が $0$ の資産を含めることができる。

#definition[
  収益率の分散が $0$ の資産を#term-meta((kana: "あんぜんしさん", ja: "安全資産", en: "risk-free asset"))#strong[安全資産]（risk-free asset）と呼ぶ。その収益率を $r_f$ と書く。分散が正である資産を#term-meta((kana: "りすくしさん", ja: "リスク資産", en: "risky asset"))#strong[リスク資産]（risky asset）と呼ぶ。
]

分散が $0$ なら確率 $1$ で収益率は $r_f$ に一致する。この $r_f$ は#term-meta((kana: "むりすくきんり", ja: "無リスク金利", en: "risk-free rate"))#strong[無リスク金利]（risk-free rate）とも呼ばれる。国債や銀行預金は、デフォルトの可能性を無視すれば安全資産の近似である。本書では投資家は安全資産を金利 $r_f$ でいくらでも貸し借りできると仮定する。貸し借りとは安全資産への投資と、安全資産を担保にした借金のことである。この仮定は CAPM の仮定群の一つとして第 7 章で改めて整理される。
