#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, term-meta
#import "@preview/cetz:0.5.2"

= 資本資産価格モデル

ここまでの章では、一人の投資家がポートフォリオを選ぶ問題を分析した。この章では視点を市場全体に移し、すべての投資家が同じ合理性的な規則に従うとき、市場に均衡が成立すると何が起こるかを分析する。その結果が資本資産価格モデル（Capital Asset Pricing Model、CAPM）であり、市場ポートフォリオがシャープレシオ最大のポートフォリオと一致するという、本書の主定理への最後の階段になる。

== CAPM の仮定

前章までの分析を市場全体に適用するために、次の仮定を置く。これらの仮定はシャープ @sharpe1964、リントナー @lintner1965、モッシン @mossin1966 の定式化に沿う標準的なものである。

#axiom[
  （平均分散選好）すべての投資家は @axiom-ms の平均分散選好の単調性に従う。
]<axm-ms>

#axiom[
  （同質期待）すべての投資家は各資産の期待収益率と分散共分散行列について、同一の値を見積もっている。
]<axm-homogeneous>

#axiom[
  （価格受容者）各投資家の投資額は市場全体に比べて小さく、単独では資産の価格に影響を与えない。
]<axm-price-taker>

#axiom[
  （安全資産）すべての投資家は金利 $r_f$ で安全資産を望むだけ貸し借りできる。
]<axm-riskfree>

#axiom[
  （摩擦の不存在）取引コストと税は存在しない。資産は任意の大きさに分割して売買できる。
]<axm-frictionless>

#axiom[
  （供給の固定）危険資産の発行済み数量は固定されており、投資家の行動によっては変化しない。
]<axm-supply>

@axm-ms と @axm-riskfree は第 4 章と第 6 章の分析を各投資家に適用するための仮定である。@axm-homogeneous は全員が同じ情報を同じように解釈するという、この章の結論を最も強く支える仮定である。第 9 章でこれらの仮定の現実性を改めて吟味する。

以下、投資家は $k = 1, 2, ..., m$ と番号付けし、投資家 $k$ の期首の投資可能額を $M_k$ と書く。市場全体の投資可能額は $M = M_1 + ... + M_m$ である。

== 分離定理

最初の結果は、リスク資産の選択が投資家の個人差に依らないことである。

#theorem[
  （分離定理、トービン @tobin1958）@axm-ms と @axm-riskfree の下で、各投資家のリスク資産ポートフォリオは、@thm-tangency による接点ポートフォリオ $bold(w)^"*"$ に一致する。
]<thm-separation>

#proof[
  @axm-ms の下で、投資家の評価は期待収益率 $mu$ と標準偏差 $sigma$ で表される。投資家が $sigma > 0$ のリスクを選ぶなら、@thm-sharpe-bound の証明が示すように、到達点 $(sigma, mu)$ は $mu = r_f + S_p sigma$ の直線上にある。ここで $p$ は投資家が選んだリスク資産ポートフォリオである。この直線は $p$ と安全資産の組み合わせであり、任意のリスク水準 $sigma$ をこの直線上で実現できるのは、@axm-riskfree によりどの投資家も金利 $r_f$ で望むだけ貸し借りできるためである。とくに $sigma > sigma_p$ の水準は $w > 1$ の借り入れで、$sigma = 0$ は全額の貸し付けで実現される。$sigma > 0$ を固定すれば、$mu$ を最大にするには $S_p$ を最大にするほかない。$S_p$ の最大値は @thm-tangency により接点ポートフォリオで達成される。したがって、リスクを取る投資家のリスク資産ポートフォリオは $bold(w)^"*"$ である。$sigma = 0$ を選ぶ投資家は全額を安全資産に置き、リスク資産ポートフォリオの選択は問題にならない。
]

この定理が分離と呼ばれるのは、投資判断が二つの独立した決定に分かれるためである。第一の決定はリスク資産どうしの配分であり、これはすべての投資家に共通で $bold(w)^"*"$ である。第二の決定は接点ポートフォリオに全体の資金のうちいくらを投じるかであり、ここにリスク許容度の個人差が現れる。投資家 $k$ がリスク資産に振り向ける割合を $alpha_k$ と書くと、$alpha_k$ は各自の選好で決まる一方、その内部構成は共通の $bold(w)^"*"$ である。

@axm-homogeneous の役割に注意されたい。@thm-separation そのものは各投資家がそれぞれの推定で接点ポートフォリオを計算すれば成立する。しかし、全員の接点ポートフォリオが同一の重みになるには、全員が同じ $tilde(bold(mu))$ と $bold(Sigma)$ を使うこと、すなわち同質期待が必要である。

== 市場の均衡と市場ポートフォリオ

=== 市場ポートフォリオ

すべての投資家の危険資産の保有を集計したものを市場ポートフォリオと呼ぶ。

#definition[
  投資家 $k$ の危険資産のうち資産 $i$ への投資額を $I_(i k)$ と書く。市場ポートフォリオの重みを
  $ w_i^M = (sum_(k=1)^m I_(i k)) / (sum_(k=1)^m sum_(j=1)^n I_(j k)) $ <eq-market-portfolio>
  と定め、$bold(w)^M = (w_1^M, ..., w_n^M)$ を#term-meta((kana: "しじょうぽーとふぉりお", ja: "市場ポートフォリオ", en: "market portfolio"))#strong[市場ポートフォリオ]（market portfolio）と呼ぶ。
]<def-market>

市場ポートフォリオは市場に存在する危険資産の全体像を、実際の保有金額で加重して表したポートフォリオである。この重みが何と一致するかは、次章で市場の供給側から特定される。

=== 均衡

#definition[
  各資産について、投資家全体の需要が供給に等しくなるとき、市場は#term-meta((kana: "きんこう", ja: "均衡", en: "equilibrium"))#strong[均衡]（equilibrium）していると言う。@axm-supply の下では、均衡は各資産の総保有数量が発行済み数量に等しい状態として、投資家の保有を通じて定義される。
]<def-equilibrium>

均衡では、だれかが買い持ちたい額はだれかが売り持ちたい額とちょうど釣り合っている。価格が均衡価格から外れていれば、需要と供給の不一致が価格を押し戻すと考えられるため、均衡は市場が落ち着く先の状態として分析の対象になる。

均衡が公理の一つに数えられていないことに注意する。公理は投資家の行動と市場の環境についての仮定であり、均衡は需要と供給が釣り合う状態に名前を付けた定義である。したがって本書の定理は、市場が均衡しているならば、という条件文の形で述べる。需給をちょうど清算する価格の存在は一般均衡理論の中心問題であり、本書は均衡の成立そのものは仮定せず、均衡が成り立っているときに何が言えるかを明らかにする。

=== 市場ポートフォリオの効率性

本章の中心結果を示す。

#theorem[
  （市場ポートフォリオの効率性）@axm-ms、@axm-homogeneous、@axm-riskfree、@axm-supply の下で均衡が成立しているならば、市場ポートフォリオは接点ポートフォリオに一致する。
  $ bold(w)^M = bold(w)^"*" $ <eq-market-tangency>
]<thm-market>

#proof[
  @thm-separation と @axm-homogeneous より、リスクを取るすべての投資家のリスク資産ポートフォリオは同一の $bold(w)^"*"$ である。投資家 $k$ が危険資産に投じる総額は $alpha_k M_k$ と書ける。$alpha_k = 0$ の投資家は危険資産を保有せず、以下の和に寄与しない。資産 $i$ に対する投資家 $k$ の投資額は $alpha_k M_k w_i^"*"$ である。@def-market に代入すると
  $ w_i^M = (sum_(k=1)^m alpha_k M_k w_i^"*") / (sum_(k=1)^m sum_(j=1)^n alpha_k M_k w_j^"*") = (w_i^"*" sum_(k=1)^m alpha_k M_k) / (sum_(k=1)^m alpha_k M_k sum_(j=1)^n w_j^"*") = w_i^"*" $
  分母で使った $sum_(j=1)^n w_j^"*" = 1$ は重みの定義による。分子分母とも少なくとも一人は $alpha_k > 0$ である限り正であり、均衡では全員が $alpha_k = 0$ となることはない。全員が $alpha_k = 0$ なら危険資産への需要はゼロになるが、@axm-supply のもとで発行済み数量は固定された正の値であるため、需要は供給と釣り合わないからである。よって $bold(w)^M = bold(w)^"*"$ である。
]

#corollary[
  @axm-ms、@axm-homogeneous、@axm-riskfree、@axm-supply の下での均衡において、市場ポートフォリオはリスク資産ポートフォリオの中で最大のシャープレシオを持つ。
]

#proof[
  @thm-market と @thm-tangency を合わせるだけである。市場ポートフォリオが接点ポートフォリオに一致し、接点ポートフォリオが定義より最大シャープレシオを持つ。
]

この結果が本書の主題への道筋である。あとに残るのは、市場ポートフォリオの時価総額加重平均としての特定である。それを行う前に、CAPM のもう一つの成果を導いておく。

== ベータと証券市場線

ポートフォリオの収益率と個別資産の収益率の共分散は、分散共分散行列と重みの積で書ける。

#lemma[
  ポートフォリオ $bold(w)$ の収益率 $R_p = sum_(j=1)^n w_j R_j$ と資産 $i$ の収益率 $R_i$ の共分散は
  $ "Cov"[R_i, R_p] = sum_(j=1)^n w_j sigma_(i j) $ <eq-cov-portfolio>
  であり、これは $bold(Sigma) bold(w)$ の第 $i$ 成分に等しい。
]<lem-cov-portfolio>

#proof[
  @eq-cov-linear で $X = R_i$、$Y_j = R_j$、$a_j = w_j$ とすると第一の等式が得られる。$bold(Sigma) bold(w)$ の第 $i$ 成分は定義より $sum_(j=1)^n sigma_(i j) w_j$ であり、一致する。
]

#definition[
  資産 $i$ の#term-meta((kana: "べーた", ja: "ベータ", en: "beta"))#strong[ベータ]（beta）を
  $ beta_i = sigma_(i M) / sigma_M^2 = "Cov"[R_i, R_M] / V[R_M] $ <eq-beta-def>
  と定める。ここで $R_M$ は市場ポートフォリオの収益率である。
]

#corollary[
  $X = R_i - beta_i R_M$ と置くと $"Cov"[X, R_M] = 0$ が成り立つ。すなわち、資産 $i$ の収益率は
  $ R_i = beta_i R_M + X, quad "Cov"[X, R_M] = 0 $ <eq-beta-decomp>
  と、市場と無相関な収益率 $X$ を残す形に分解できる。
]<cor-beta-decomp>

#proof[
  @lem-cov-linear と共分散の対称性より
  $ "Cov"[R_i - beta_i R_M, R_M] = "Cov"[R_i, R_M] - beta_i V[R_M] $
  であり、この右辺はベータの定義 @eq-beta-def により $0$ である。
]

この分解の意味を確かめる。資産 $i$ の収益率のうち、市場に比例して動く成分は $beta_i R_M$ であり、市場ポートフォリオの収益率が $1%$ 動くときこの成分は $beta_i %$ 動く。残りの $X$ は市場と無相関で、市場の動きに比例する成分を持たない。ベータは、市場ポートフォリオの収益率が $1%$ 動くとき資産 $i$ の収益率が平均して何%動くかを測る量であるという読みは、この意味で正当化される。CAPM の主結果は、期待収益率の市場を超える部分がベータに比例するというものである。

#theorem[
  （証券市場線、CAPM）@axm-ms、@axm-homogeneous、@axm-riskfree、@axm-supply の下での均衡において、各資産 $i$ の期待収益率は
  $ mu_i = r_f + beta_i (mu_M - r_f) $ <eq-sml>
  を満たす。$mu_M$ は市場ポートフォリオの期待収益率である。
]<thm-sml>

#proof[
  この証明で公理が使われるのは @thm-market を通じてのみであり、以下ではそこから導かれた市場ポートフォリオの重みの性質のみを用いる。@thm-market より市場ポートフォリオは接点ポートフォリオであり、@thm-tangency の重みは $bold(Sigma)^(-1) tilde(bold(mu))$ に正の定数を掛けたものである。両辺に左から $bold(Sigma)$ を掛けると
  $ bold(Sigma) bold(w)^M = c tilde(bold(mu)), quad c = 1 / (bold(1)^T bold(Sigma)^(-1) tilde(bold(mu))) > 0 $ <eq-sigma-wm>
  である。第 $i$ 成分を取り、@lem-cov-portfolio を使うと
  $ c (mu_i - r_f) = sum_(j=1)^n w_j^M sigma_(i j) = "Cov"[R_i, R_M] $
  である。この等式を $i$ に市場ポートフォリオ自身を代入して係数 $c$ を確定する。市場ポートフォリオの収益率は $R_M = sum_j w_j^M R_j$ だから、左辺は $c (mu_M - r_f)$、右辺は $"Cov"[R_M, R_M] = sigma_M^2$ である。よって
  $ c = sigma_M^2 / (mu_M - r_f) $
  である。これを先の等式に代入して整理すると
  $ mu_i - r_f = ("Cov"[R_i, R_M] / sigma_M^2) (mu_M - r_f) = beta_i (mu_M - r_f) $
  が得られる。
]

@thm-sml の関係を、$beta$-$mu$ 平面上の直線として描いたものを#term-meta((kana: "しょうけんしじょうせん", ja: "証券市場線", en: "security market line"))#strong[証券市場線]（Security Market Line、SML）と呼ぶ。切片は $r_f$、傾きは $mu_M - r_f$ である（@fig-sml）。傾きの $mu_M - r_f$ は市場ポートフォリオの超過収益率であり、#term-meta((kana: "しじょうりすくぷれみあむ", ja: "市場リスクプレミアム", en: "market risk premium"))#strong[市場リスクプレミアム]（market risk premium）と呼ばれる。リスクを負って市場に投じることへの報酬を市場全体で測った量であって、@def-risk-premium で定義した個々の投資家のリスクプレミアムとは別の量である。

#figure(
  cetz.canvas(length: 0.3cm, {
    import cetz.draw: *
    line((0, 0), (30, 0), stroke: 0.7pt + black)
    line((0, 0), (0, 11), stroke: 0.7pt + black)
    content((30, -0.7), [$beta$], anchor: "north-east")
    content((0, 11.4), [$mu$], anchor: "south")
    // security market line: mu = r_f + (mu_M - r_f) beta
    let rf = 2
    let mm = 8
    let slope = (mm - rf) / 10
    line((0, rf), (16, rf + 16 * slope), stroke: 0.9pt + black)
    circle((0, rf), radius: 0.22, fill: black)
    content((-0.8, rf), [$r_f$], anchor: "east")
    circle((10, mm), radius: 0.22, fill: black)
    line((10, 0), (10, mm), stroke: 0.4pt + gray, dash: "dotted")
    line((0, mm), (10, mm), stroke: 0.4pt + gray, dash: "dotted")
    content((10, -0.8), [$1$], anchor: "north")
    content((-0.8, mm), [$mu_M$], anchor: "east")
    circle((5, rf + 5 * slope), radius: 0.22, fill: black)
    content((6.5, 4.6), [個別資産], anchor: "west")
    line((6.4, 4.75), (5.4, 4.95), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((13, 8.5), [市場ポートフォリオ], anchor: "west")
    line((12.9, 8.5), (10.6, 8.15), stroke: 0.5pt + black, mark: (end: (symbol: ">", scale: 0.7)))
    content((3, 3.6), [傾き $= mu_M - r_f$], anchor: "north-west")
  }),
  caption: [証券市場線：均衡ではすべての資産がこの直線上に乗る],
  supplement: [図],
)<fig-sml>

@eq-sml は、均衡で各資産の期待収益率がベータによって決まることを示す式であり、#strong[資産価格の式]とも呼ばれる。

この定理の含意は深い。@cor-beta-decomp の分解における二つの成分に名前を付ける。市場とともに動く成分 $beta_i R_M$ を#term-meta((kana: "けいとうてきりすく", ja: "系統的リスク", en: "systematic risk"))#strong[系統的リスク]（systematic risk）、市場と無相関な残りの成分 $X$ を#term-meta((kana: "ひたいけいてきりすく", ja: "非体系的リスク", en: "idiosyncratic risk"))#strong[非体系的リスク]（idiosyncratic risk）と呼ぶ。

均衡では、資産の期待収益率の市場超過分を決めるのは、資産単独の分散 $sigma_i^2$ ではなくベータである。理由は次の通りである。@lem-cov-portfolio より、資産がポートフォリオのリスクを増やす度合いは、その資産とポートフォリオの共分散で測られる。市場ポートフォリオをすでに保有する投資家にとって、資産 $i$ を付け加えてリスクを増やすのは共分散 $sigma_(i M)$、すなわちベータに比例する系統的リスクの部分だけであり、非体系的リスクの寄与は $"Cov"[X, R_M] = 0$ により消える。したがって市場は、市場ポートフォリオのリスクを増やさない非体系的リスクに対して報酬を払わない。報酬が払われるのは系統的リスクに対してだけであり、@eq-sml の右辺に現れるのがベータのみであることは、このことの表れである。

#remark[
  資産 $i$ の#term-meta((kana: "あるふぁ", ja: "アルファ", en: "alpha"))#strong[アルファ]（alpha）を
  $ alpha_i = mu_i - r_f - beta_i (mu_M - r_f) $
  と定める。@thm-sml の主張は、均衡ではすべての資産のアルファが $0$ になることを意味する。アルファは、資産の期待収益率が理論の予測からどれだけ離れているかを測る量であり、能動的な運用の成績評価に広く使われる。均衡の仮定が満たされない市場では、アルファが $0$ でない資産があり得る。
]

== 市場ポートフォリオと平均分散効率

CAPM が導かれた過程を振り返ると、資産価格の式 @thm-sml は、市場ポートフォリオが接点ポートフォリオであるという事実 @thm-market から導かれた。逆向きの関係も成り立つ。

#corollary[
  $mu_M > r_f$ とし、@eq-sml がすべての資産について成り立つとする。このとき $bold(1)^T bold(Sigma)^(-1) tilde(bold(mu)) > 0$ であり、市場ポートフォリオは接点ポートフォリオに一致する。
]<cor-sml-converse>

#proof[
  @lem-cov-portfolio より $"Cov"[R_i, R_M] = (bold(Sigma) bold(w)^M)_i$ である。仮定とベータの定義 @eq-beta-def より、各資産 $i$ について
  $ mu_i - r_f = ("Cov"[R_i, R_M] / sigma_M^2) (mu_M - r_f) $
  が成り立つ。$c = sigma_M^2 / (mu_M - r_f) > 0$ とおくと、この式は成分ごとにまとめて $bold(Sigma) bold(w)^M = c tilde(bold(mu))$、すなわち @thm-sml の証明で導いた関係と同じものを表す。両辺の左から $bold(Sigma)^(-1)$ を掛けると $bold(w)^M = c bold(Sigma)^(-1) tilde(bold(mu))$ である。$bold(1)^T bold(w)^M = 1$ より $bold(1)^T bold(Sigma)^(-1) tilde(bold(mu)) = 1\/c > 0$ であり、@thm-tangency の重みはこの正の定数で割って予算制約を満たすようにしたものであるから、$bold(w)^M = bold(w)^"*"$ である。
]

この同値性は、市場ポートフォリオの効率性と資産価格の式が同じ事実の二つの現れであることを意味する。

本書の最終目的は資産価格の決定ではなく、時価総額加重平均の効率性である。そのために必要なのは @thm-market と、市場ポートフォリオが時価総額加重平均と一致することの確認である。後者を次章で示し、本書の主定理を完成させる。
