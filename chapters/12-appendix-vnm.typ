#import "../setup.typ": definition, axiom, theorem, lemma, corollary, example, remark, proof, eqref, appendix-count, term-meta

#appendix-count.update(3)

#heading(numbering: none)[付録C　期待効用表現定理の証明]

この付録では、第 4 章で期待効用仮説の根拠として採用した @thm-vnm の証明を与える。証明はフォン・ノイマンとモルゲンシュテルンによる原著 @vonneumann1947 の標準的な構成に沿う。

#heading(level: 2, numbering: none)[C.1　くじと選好の形式化]

結果としてありうる金額は有限個あり、$x_1, x_2, ..., x_n$ と番号付けされているとする。#strong[くじ]（lottery）とは、結果 $x_i$ が確率 $p_i$ で実現するような確率の組 $bold(p) = (p_1, ..., p_n)$ である。各 $p_i$ は $p_i >= 0$、$sum_(i=1)^n p_i = 1$ を満たす。結果 $x_i$ を確率 $1$ で与えるくじ、すなわち第 $i$ 成分だけが $1$ のくじを $bold(delta)_i$ と書く。

二つのくじ $bold(p), bold(q)$ と $lambda in [0, 1]$ に対して、#strong[混合]と呼ばれるくじを
$ (lambda bold(p) + (1 - lambda) bold(q))_i = lambda p_i + (1 - lambda) q_i $
と定める。混合は確率 $lambda$ でくじ $bold(p)$ を、確率 $1 - lambda$ でくじ $bold(q)$ を引く二段階のくじを、一段階のくじに書き直したものである。

投資家の選好はくじの集合上の二項関係 $succ.eq$（弱選好）で表される。$bold(p) succ.eq bold(q)$ は $bold(p)$ が $bold(q)$ 以上に望ましいことを意味し、$bold(p) succ.eq bold(q)$ かつ $bold(q) succ.eq bold(p)$ のとき $bold(p) tilde bold(q)$（無差別）、$bold(p) succ.eq bold(q)$ かつ $bold(q) succ.eq.not bold(p)$ のとき $bold(p) succ bold(q)$（厳密な選好）と書く。

期待効用表現の公理を、次の四つとして形式化する。

#axiom[
  （完全性）任意のくじ $bold(p), bold(q)$ に対して、$bold(p) succ.eq bold(q)$ または $bold(q) succ.eq bold(p)$ が成り立つ。
]<ax-complete>

#axiom[
  （推移性）$bold(p) succ.eq bold(q)$ かつ $bold(q) succ.eq bold(r)$ ならば $bold(p) succ.eq bold(r)$ である。
]<ax-transitive>

#axiom[
  （連続性）各成分が収束するくじの列 $bold(p)_k -> bold(p)$ に対して、すべての $k$ で $bold(p)_k succ.eq bold(q)$ ならば $bold(p) succ.eq bold(q)$ であり、すべての $k$ で $bold(q) succ.eq bold(p)_k$ ならば $bold(q) succ.eq bold(p)$ である。
]<ax-continuous>

#axiom[
  （独立性）任意のくじ $bold(p), bold(q), bold(r)$ と $lambda in (0, 1]$ に対して、
  $ bold(p) succ.eq bold(q) quad <=> quad lambda bold(p) + (1 - lambda) bold(r) succ.eq lambda bold(q) + (1 - lambda) bold(r) $
  が成り立つ。
]<ax-independence>

連続性の公理は、選好が確率の微小な変化で不連続に反転しないことを述べている。独立性の公理は、共通の第三のくじとの混合によって選好が反転しないことを述べている。証明の目標は次の定理である。

#theorem[
  （期待効用表現）@ax-complete、@ax-transitive、@ax-continuous、@ax-independence のもとで、次が成り立つ。
  + 実数列 $u_1, ..., u_n$ で
    $ bold(p) succ.eq bold(q) quad <=> quad sum_(i=1)^n p_i u_i >= sum_(i=1)^n q_i u_i $ <eq-vnm-app>
    を満たすものが存在する。
  + 二つの実数列 $u_i$ と $v_i$ がともに (i) を満たすならば、ある $a > 0$ と $b$ が存在して $v_i = a u_i + b$（すべての $i$）となる。
]<thm-vnm-app>

証明の考え方は次の通りである。最良のくじと最悪のくじを基準に取り、任意のくじ $bold(p)$ に、それと無差別な「最良と最悪の混合の係数」$u(bold(p))$ を対応させる。この係数がくじの混合に関して線形であることを独立性公理から示し、期待効用の形に仕上げる。

#heading(level: 2, numbering: none)[C.2　準備の補題]

まず、有限集合には最良と最悪のくじが選べること、混合の係数について選好が単調であること、中間のくじがちょうど一つ定まることを示す。

#lemma[
  （最良と最悪の存在）くじの全体には、すべてのくじ $bold(p)$ に対して $bold(b) succ.eq bold(p)$ を満たすくじ $bold(b)$ と、すべてのくじ $bold(p)$ に対して $bold(p) succ.eq bold(w)$ を満たすくじ $bold(w)$ が存在する。
]<lem-best-worst>

#proof[
  くじの候補が $m$ 個あるとき、最大元の存在を帰納法で示す。$m = 1$ なら自明である。$m - 1$ 個の中に最大元 $bold(m)$ が存在すると仮定し、$m$ 番目のくじを $bold(p)$ とする。@ax-complete より $bold(m) succ.eq bold(p)$ または $bold(p) succ.eq bold(m)$ であり、大きい方を取れば $m$ 個全体の最大元になる。くじの全体は有限集合ではないが、任意のくじ $bold(p) = sum_(i=1)^n p_i bold(delta)_i$ は確定くじの混合として書ける。そこで、まず $n$ 個の確定くじ $bold(delta)_1, ..., bold(delta)_n$ の中で最大のもの $bold(b)$ と最小のもの $bold(w)$ を帰納法で選ぶ。任意のくじがこれらの混合であることから、$bold(b)$ と $bold(w)$ が全体の最大・最小になることが (i) の証明の末尾で確認される。ここでは $bold(b)$ と $bold(w)$ の選び方だけを定めて先へ進む。
]

#lemma[
  （単調性）$1 >= alpha > beta >= 0$ ならば
  $ alpha bold(b) + (1 - alpha) bold(w) succ beta bold(b) + (1 - beta) bold(w) $
  が成り立つ。ただし $bold(b) succ bold(w)$ とする。
]<lem-monotone>

#proof[
  二段階で示す。第一段階として、$0 <= beta < 1$ に対して
  $ beta bold(b) + (1 - beta) bold(w) succ bold(w) $ <eq-strict-mix>
  が成り立つことを確かめる。$bold(b) succ bold(w)$ に @ax-independence を $bold(r) = bold(w)$、割合 $beta$ で適用すると
  $ beta bold(b) + (1 - beta) bold(w) succ.eq beta bold(w) + (1 - beta) bold(w) = bold(w) $
  が得られる。ここで等号、すなわち無差別が成り立ったと仮定する。$beta in (0, 1)$ ならば、この無差別関係に @ax-independence の同値性を逆向きに適用して $bold(b) tilde bold(w)$ が従い、仮定に矛盾する。$beta = 0$ の場合は左辺が $bold(w)$ 自身であり @eq-strict-mix は $bold(b) succ bold(w)$ そのものだから成り立つ。よって @eq-strict-mix は厳密な選好である。

  第二段階として、$lambda = (alpha - beta)\/(1 - beta) in (0, 1]$ を使った分解
  $ alpha bold(b) + (1 - alpha) bold(w) = lambda bold(b) + (1 - lambda) (beta bold(b) + (1 - beta) bold(w)) $ <eq-decompose>
  を用いる。この等式は右辺の $bold(b)$ の係数が
  $ lambda + (1 - lambda) beta = (alpha - beta)\/(1 - beta) + (beta (1 - alpha))\/(1 - beta) = (alpha (1 - beta))\/(1 - beta) = alpha $
  となり、$bold(w)$ の係数も $1 - alpha$ に一致することから確かめられる。@eq-strict-mix は $bold(b) succ beta bold(b) + (1 - beta) bold(w)$ と読める。これに @ax-independence を $bold(r) = beta bold(b) + (1 - beta) bold(w)$、割合 $lambda$ で適用すると、混合の両辺から共通の第三項が相殺され
  $ lambda bold(b) + (1 - lambda) bold(r) succ lambda bold(r) + (1 - lambda) bold(r) = bold(r) $
  となる。ここで $bold(r) = beta bold(b) + (1 - beta) bold(w)$ である。@eq-decompose を左辺に使えば、これは
  $ alpha bold(b) + (1 - alpha) bold(w) succ beta bold(b) + (1 - beta) bold(w) $
  と書き直せる。これが主張である。
]

#lemma[
  （中間くじの一意存在）$bold(b) succ.eq bold(p) succ.eq bold(w)$ を満たす任意のくじ $bold(p)$ に対して、
  $ alpha bold(b) + (1 - alpha) bold(w) tilde bold(p) $
  を満たす $alpha in [0, 1]$ がただ一つ存在する。
]<lem-intermediate>

#proof[
  （一意性）$alpha != beta$ とすると、@lem-monotone により二つの混合どうしに厳密な選好が成り立つため、両方が $bold(p)$ と無差別になることはない。

  （存在）集合を二つ
  $ A = "{"alpha in [0, 1] : alpha bold(b) + (1 - alpha) bold(w) succ.eq bold(p)"}" $
  と定め、$B$ を
  $ B = "{"alpha in [0, 1] : bold(p) succ.eq alpha bold(b) + (1 - alpha) bold(w)"}" $
  と定める。$alpha = 1$ の混合は $bold(b)$ なので $1 in A$、$alpha = 0$ の混合は $bold(w)$ なので $0 in B$ である。@ax-complete より各 $alpha$ は $A$ と $B$ の少なくとも一方に属し、$A union B = [0, 1]$ である。さらに、@ax-continuous により $A$ と $B$ は閉集合である。実際、$A$ に属する列 $alpha_k -> alpha$ を取ると、対応するくじの列 $alpha_k bold(b) + (1 - alpha_k) bold(w)$ は各成分が $alpha_k -> alpha$ に対応して収束し、すべての $k$ で $bold(p)$ 以上に選好されているので、@ax-continuous から極限のくじも $bold(p)$ 以上であり $alpha in A$ となる。$B$ も同様である。区間 $[0, 1]$ は二つの閉集合の合併として書けるが、$A$ と $B$ が交わらないとすると、$[0, 1]$ は交わらない二つの空でない閉集合に分離されることになる。これは、$A$ の補集合が $B$ の内部を含む開集合となることから、$[0, 1]$ が二つの空でない開集合に分割できることを意味し、区間の連結性に矛盾する。したがって $A ∩ B != nothing$ であり、この共通部分に属する $alpha$ では両方の弱選好が成り立ち、無差別 $alpha bold(b) + (1 - alpha) bold(w) tilde bold(p)$ が得られる。
]

連結性の議論を初等的に言い換えれば、$A$ と $B$ が交わらない場合、$A$ は $0$ を含まない空でない閉集合なのでその下限 $alpha^* > 0$ を持ち、$B$ は $1$ を含まない空でない閉集合なのでその上限 $beta^* < 1$ を持つ。閉性から $alpha^* in A$、$beta^* in B$ であり、さらに @lem-monotone と推移性により、$A$ に属する点より大きい点はすべて $A$ に属し、$B$ に属する点より小さい点はすべて $B$ に属する。したがって $alpha^* > beta^*$ なら間の点はどちらにも属さず $A union B = [0, 1]$ と矛盾し、$alpha^* < beta^*$ なら間の点は $A$ と $B$ の両方に属して仮定と矛盾し、$alpha^* = beta^*$ ならその点は $A ∩ B$ に属して、やはり仮定と矛盾する。

#heading(level: 2, numbering: none)[C.3　効用の構成と存在の証明]

以下、$bold(b) succ bold(w)$ と仮定して証明を進める。すべてのくじが互いに無差別である場合（$bold(b) tilde bold(w)$ の場合）には、任意の定数列 $u_1 = ... = u_n$ が (i) を満たすので自明である。この場合の選好は自明な選好と呼ばれる。

各くじ $bold(p)$ に対して、@lem-intermediate の係数を
$ u(bold(p)) = alpha(bold(p)) $ <eq-def-u>
と書き、$bold(p)$ の効用と呼ぶ。定義より
$ bold(p) tilde u(bold(p)) bold(b) + (1 - u(bold(p))) bold(w) $
である。$u(bold(b)) = 1$、$u(bold(w)) = 0$ である。

#lemma[
  （簡約）$bold(p) tilde bold(p)'$、$bold(q) tilde bold(q)'$ ならば、任意の $lambda in [0, 1]$ に対して
  $ lambda bold(p) + (1 - lambda) bold(q) tilde lambda bold(p)' + (1 - lambda) bold(q)' $
  が成り立つ。
]<lem-reduction>

#proof[
  $bold(p) succ.eq bold(p)'$ に @ax-independence を $bold(r) = bold(q)$、割合 $lambda$ で適用すると
  $ lambda bold(p) + (1 - lambda) bold(q) succ.eq lambda bold(p)' + (1 - lambda) bold(q) $
  である。逆向きの弱選好 $bold(p)' succ.eq bold(p)$ からは反対の不等号が同様に得られる。両方合わせて
  $ lambda bold(p) + (1 - lambda) bold(q) tilde lambda bold(p)' + (1 - lambda) bold(q) $
  である。この結果を、$bold(q) tilde bold(q)'$ に対して今得た無差別関係と @ax-independence で再び適用すれば（$bold(p)$ の役割を $lambda bold(p) + (1 - lambda) bold(q)$、$bold(q)$ の役割を $lambda bold(p)' + (1 - lambda) bold(q)$ と読み替え、第三のくじとして割合 $1 - lambda$ 側を使う）、
  $ lambda bold(p) + (1 - lambda) bold(q) tilde lambda bold(p)' + (1 - lambda) bold(q)' $
  が成り立つ。
]

#lemma[
  （表現）任意のくじ $bold(p), bold(q)$ に対して、
  $ bold(p) succ.eq bold(q) quad <=> quad u(bold(p)) >= u(bold(q)) $
  が成り立つ。
]<lem-representation>

#proof[
  $u(bold(p)) >= u(bold(q))$ とする。@eq-def-u の無差別関係と @lem-reduction（$lambda = 1$ 側と $lambda = 0$ 側を段階的に使う）により、$bold(p)$ と $bold(q)$ の選好の順序は、それぞれの混合 $u(bold(p)) bold(b) + (1 - u(bold(p))) bold(w)$ と $u(bold(q)) bold(b) + (1 - u(bold(q))) bold(w)$ の選好の順序と一致する。$u(bold(p)) > u(bold(q))$ なら @lem-monotone より前者が厳密に選好され、$u(bold(p)) = u(bold(q))$ なら二つの混合は一致し無差別である。いずれの場合も $bold(p) succ.eq bold(q)$ が成り立つ。逆向きは、$bold(p) succ bold(q)$ と仮定して $u(bold(p)) < u(bold(q))$ なら先の議論の向きから $bold(q) succ bold(p)$ となり完全性と合わせて矛盾することによる。
]

#lemma[
  （混合に関する線形性）任意のくじ $bold(p), bold(q)$ と $lambda in [0, 1]$ に対して、
  $ u(lambda bold(p) + (1 - lambda) bold(q)) = lambda u(bold(p)) + (1 - lambda) u(bold(q)) $
  が成り立つ。
]<lem-affine>

#proof[
  $bold(p) tilde u(bold(p)) bold(b) + (1 - u(bold(p))) bold(w)$、$bold(q) tilde u(bold(q)) bold(b) + (1 - u(bold(q))) bold(w)$ に @lem-reduction を適用すると
  $ lambda bold(p) + (1 - lambda) bold(q) tilde lambda (u(bold(p)) bold(b) + (1 - u(bold(p))) bold(w)) + (1 - lambda)(u(bold(q)) bold(b) + (1 - u(bold(q))) bold(w)) $
  右辺はくじの成分ごとの計算により、$bold(b)$ の係数が $lambda u(bold(p)) + (1 - lambda) u(bold(q))$、$bold(w)$ の係数がそれの $1$ 補である混合に等しい。すなわち
  $ tilde (lambda u(bold(p)) + (1 - lambda) u(bold(q))) bold(b) + (1 - lambda u(bold(p)) - (1 - lambda) u(bold(q))) bold(w) $
  である。中間くじの一意性 @lem-intermediate により、この混合と無差別な係数はただ一つなので
  $ u(lambda bold(p) + (1 - lambda) bold(q)) = lambda u(bold(p)) + (1 - lambda) u(bold(q)) $
  が成り立つ。
]

これで定理の (i) を証明する準備が整った。

#proof[
  （@thm-vnm-app の (i) の証明）確定くじ $bold(delta)_i$ の効用を $u_i = u(bold(delta)_i)$ と置く。任意のくじ $bold(p) = sum_(i=1)^n p_i bold(delta)_i$ に対して、@lem-affine を成分ごとに繰り返し適用すると
  $ u(bold(p)) = sum_(i=1)^n p_i u(bold(delta)_i) = sum_(i=1)^n p_i u_i $
  が成り立つ。帰納法による詳細は次の通りである。$n = 1$ は自明である。$bold(p) = sum_(i=1)^n p_i bold(delta)_i$ を $bold(p) = lambda bold(p)' + (1 - lambda) bold(delta)_n$（$lambda = sum_(i=1)^(n-1) p_i$、$bold(p)' = (p_1\/lambda, ..., p_(n-1)\/lambda, 0)$）と書くと、@lem-affine と帰納法の仮定から
  $ u(bold(p)) = lambda u(bold(p)') + (1 - lambda) u_n = lambda sum_(i=1)^(n-1) (p_i\/lambda) u_i + p_n u_n = sum_(i=1)^n p_i u_i $
  となる。ただし $lambda = 0$ の場合は $bold(p) = bold(delta)_n$ であり自明である。@lem-representation により
  $ bold(p) succ.eq bold(q) quad <=> quad u(bold(p)) >= u(bold(q)) quad <=> quad sum_(i=1)^n p_i u_i >= sum_(i=1)^n q_i u_i $
  であり、(i) が示された。最後に、@lem-best-worst で保留した主張、すなわち $bold(b)$ と $bold(w)$ が全体の最大・最小であることを確認する。$bold(b)$ は確定くじの中で最大であり、任意のくじ $bold(p) = sum p_i bold(delta)_i$ は確定くじの混合である。各 $bold(delta)_i succ.eq bold(w)$ に対して、@lem-reduction の証明で用いた混合での順序保存を帰納的に適用すると、$bold(p) = sum_(i=1)^n p_i bold(delta)_i succ.eq sum_(i=1)^n p_i bold(w) = bold(w)$ が従う。同様に、各 $bold(delta)_i succ.eq bold(b)$ からは $bold(b) = sum_(i=1)^n p_i bold(b) succ.eq bold(p)$ が従う。よって任意のくじ $bold(p)$ に対して $bold(b) succ.eq bold(p) succ.eq bold(w)$ であり、$bold(b)$ と $bold(w)$ はくじ全体の最大・最小である。
]

#heading(level: 2, numbering: none)[C.4　一意性]

#proof[
  （@thm-vnm-app の (ii) の証明）実数列 $u_i$ と $v_i$ がともに (i) の表現を与えるとする。まず (i) の表示から $bold(b) succ bold(w)$ に対応して $u(bold(b)) > u(bold(w))$、$v(bold(b)) > v(bold(w))$ である。ここで $u(bold(p)) = sum p_i u_i$、$v(bold(p)) = sum p_i v_i$ と置いた。任意の $alpha in [0, 1]$ の混合くじ $alpha bold(b) + (1 - alpha) bold(w)$ に対して、(i) の表示（@lem-affine を $bold(b), bold(w)$ に適用した形）から
  $ u(alpha bold(b) + (1 - alpha) bold(w)) = u(bold(w)) + alpha (u(bold(b)) - u(bold(w))) \
    v(alpha bold(b) + (1 - alpha) bold(w)) = v(bold(w)) + alpha (v(bold(b)) - v(bold(w))) $
  である。任意のくじ $bold(p)$ は、@eq-def-u により $alpha = u(bold(p))$ の混合と無差別である。無差別なくじは表現において同じ値を持つ（$bold(p) tilde bold(q)$ なら $bold(p) succ.eq bold(q)$ と $bold(q) succ.eq bold(p)$ の両方の表示から値が一致する）ので、第 2 式に $alpha = u(bold(p))$ を代入して
  $ v(bold(p)) = v(bold(w)) + u(bold(p)) dot.c (v(bold(b)) - v(bold(w))) \/ (u(bold(b)) - u(bold(w))) $
  が得られる。確定くじ $bold(delta)_i$ に適用すると
  $ v_i = a u_i + b, quad a = (v(bold(b)) - v(bold(w))) \/ (u(bold(b)) - u(bold(w))) > 0, quad b = v(bold(w)) - a u(bold(w)) $
  であり、$v$ は $u$ の正アフィン変換である。
]

(ii) が示すように、期待効用の数値そのものには意味はなく、順序を保つ正アフィン変換を除いて一意である。効用の差の比や、効用の符号といった量は選択の予測に影響しない。第 4 章で効用関数を「順序を保存する物差し」と呼んだ理由が、ここで形式的に裏付けられた。
