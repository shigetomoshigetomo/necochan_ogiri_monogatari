# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: ENV['ADMIN_EMAIL'],
              password: ENV['ADMIN_PASSWORD']
              )

Level.create!(level: 1,
              threshold: 10
              )

level = 1
for i in 1..199
  new_level = level + i
  before_level = Level.find(new_level - 1)  #一つ前のレベルを探す
  new_threshold = before_level.threshold * 1.1  #一つ前のレベルの闘値に1.1掛ける
  Level.create!(level: new_level,
                threshold: new_threshold
                )
end

User.create!(
  [
    {email: ENV['USER1_EMAIL'], name: 'ももこ', password: ENV['USER1_PASSWORD'],
    {email: ENV['USER2_EMAIL'], name: 'りんご', password: ENV['USER2_PASSWORD'],
    {email: ENV['USER3_EMAIL'], name: 'にゃんこ', password: ENV['USER3_PASSWORD'],
    {email: ENV['USER4_EMAIL'], name: '金魚', password: ENV['USER4_PASSWORD'],
    {email: ENV['USER5_EMAIL'], name: 'のりお', password: ENV['USER5_PASSWORD'],
    {email: ENV['USER6_EMAIL'], name: 'よしお', password: ENV['USER6_PASSWORD'],
    {email: ENV['USER7_EMAIL'], name: 'ゆめじ', password: ENV['USER7_PASSWORD'],
    {email: ENV['USER8_EMAIL'], name: 'うたじ', password: ENV['USER8_PASSWORD'],
    {email: ENV['USER9_EMAIL'], name: 'はるかぜピーすけ', password: ENV['USER9_PASSWORD'],
    {email: ENV['USER10_EMAIL'], name: 'チャイム', password: ENV['USER10_PASSWORD'],
    {email: ENV['USER11_EMAIL'], name: 'kiyoshi', password: ENV['USER11_PASSWORD']
  ]
)

Genre.create!([{name: "武器屋"}, {name: "道具屋"}, {name: "食堂"}, {name: "カフェ"}, {name: "旅のお供"}])

Item.create!(
  [
    {name: '緑の剣', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sword_green.png"), filename:"sword_green.png"), introduction: '大喜利初心者むけの剣です。', genre_id: 1, price: 10, having_exp: 7 },
    {name: '青の剣', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sword_blue.png"), filename:"sword_blue.png"), introduction: '大喜利中級者むけの剣です。', genre_id: 1, price: 60, having_exp: 30 },
    {name: '赤の剣', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sword_red.png"), filename:"sword_red.png"), introduction: '大喜利上級者が使う剣です。', genre_id: 1, price: 120, having_exp: 45 },
    {name: '緑の盾', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shield_green.png"), filename:"shield_green.png"), introduction: '大喜利初心者むけの盾です。', genre_id: 1, price: 9, having_exp: 6 },
    {name: '青の盾', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shield_blue.png"), filename:"shield_blue.png"), introduction: '大喜利中級者むけの剣です。', genre_id: 1, price: 55, having_exp: 20 },
    {name: '赤の盾', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shield_red.png"), filename:"shield_red.png"), introduction: '大喜利上級者が使う盾です。', genre_id: 1, price: 110, having_exp: 38 },
    {name: 'ブロンズの王冠', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/crown_01_bronze_green.png"), filename:"crown_01_bronze_green.png"), introduction: '大喜利初心者むけの王冠です。', genre_id: 1, price: 9, having_exp: 6 },
    {name: 'シルバーの王冠', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/crown_01_silver_blue.png"), filename:"crown_01_silver_blue.png"), introduction: '大喜利中級者むけの王冠です。', genre_id: 1, price: 55, having_exp: 20 },
    {name: 'ゴールドの王冠', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/crown_01_gold_red.png"), filename:"crown_01_gold_red.png"), introduction: '大喜利上級者が使う王冠です。', genre_id: 1, price: 110, having_exp: 38 },
    {name: '大喜利王の王冠', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/crown_02_gold_red.png"), filename:"crown_02_gold_red.png"), introduction: '大喜利王のみが使うことができる王冠です。', genre_id: 1, price: 300, having_exp: 150 },
    {name: 'おくすり', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/portion_lightblue_02.png"), filename:"portion_lightblue_02.png"), introduction: '飲むともっとおもしろくなるかも...。', genre_id: 2, price: 3, having_exp: 2 },
    {name: '木の実', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/fruit_pink.png"), filename:"fruit_pink.png"), introduction: '食べると元気になります。', genre_id: 2, price: 3, having_exp: 1 },
    {name: '魔法のキノコ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kinoko_purple.png"), filename:"kinoko_purple.png"), introduction: '食べるとポジティブになります。', genre_id: 2, price: 3, having_exp: 3 },
    {name: '壺', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tsubo_brown_01.png"), filename:"tsubo_brown_01.png"), introduction: '割るとスッキリします。', genre_id: 2, price: 2, having_exp: 2 },
    {name: 'おもしろくなる本', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/book_03_brown.png"), filename:"book_03_brown.png"), introduction: '大喜利のコツが書いてあります。', genre_id: 2, price: 8, having_exp: 5 },
    {name: '秘密のカギ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/key_monochrome.png"), filename:"key_monochrome.png"), introduction: 'なくさないようにしましょう。', genre_id: 2, price: 10, having_exp: 8 },
    {name: '宝箱', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/treasure_red_gold.png"), filename:"treasure_red_gold.png"), introduction: '何か入ってるかも...。', genre_id: 2, price: 100, having_exp: 50 },
    {name: 'きつねうどん', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/udon_kitsuneudon_border.png"), filename:"udon_kitsuneudon_border.png"), introduction: '甘いお出汁のつるんとしたうどんです。お揚げは一口噛むと、中から甘い煮汁がジュワーッと染み出してきます。', genre_id: 3, price: 5, having_exp: 4 },
    {name: '炙りたらこのおにぎり', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/onigiri_tarako.png"), filename:"onigiri_tarako.png"), introduction: '北海道産のたらこを使用したホカホカのおにぎりです。', genre_id: 3, price: 3, having_exp: 2 },
    {name: '焼き鮭', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yakizakana_shake_sudachi_white.png"), filename:"yakizakana_shake_sudachi_white.png"), introduction: '皮はパリパリ、身は脂が乗っていてジューシーです。', genre_id: 3, price: 4, having_exp: 3 },
    {name: 'うに丼', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kaisendon_unidon_border_oba.png"), filename:"kaisendon_unidon_border_oba.png"), introduction: 'とても濃厚なうにがたっぷりのっています。', genre_id: 3, price: 10, having_exp: 8 },
    {name: '藁焼き鰹のたたき', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sashimi_katsuo.png"), filename:"sashimi_katsuo.png"), introduction: '藁の燻製香がふわっと香ります。塩で食べると美味しいです。', genre_id: 3, price: 5, having_exp: 6 },
    {name: 'チキンライス', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/chickenrice.png"), filename:"chickenrice.png"), introduction: '昔ながらのチキンライスです。', genre_id: 3, price: 4, having_exp: 3 },
    {name: 'ミートソースパスタ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/pasta_meatsauce.png"), filename:"pasta_meatsauce.png"), introduction: '牛肉のコクと旨みが感じられる特製ミートソースです。', genre_id: 3, price: 7, having_exp: 5 },
    {name: 'マルゲリータ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/pizza_margherita.png"), filename:"pizza_margherita.png"), introduction: 'ピザ世界大会で1位になったシェフが焼いています。', genre_id: 3, price: 5, having_exp: 5 },
    {name: 'とんこつラーメン', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/ramen_tonkotsuramen_red.png"), filename:"ramen_tonkotsuramen_red.png"), introduction: 'とにかく濃い！こってり系とんこつラーメンです。', genre_id: 3, price: 4, having_exp: 5 },
    {name: 'カレーライス', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/curryrice_pork.png"), filename:"curryrice_pork.png"), introduction: 'ジャガイモ・ニンジン等がごろごろ入ったコクのある欧風カレーです。', genre_id: 3, price: 4, having_exp: 4 },
    {name: '生ビール', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/alcohol_beer_mug.png"), filename:"alcohol_beer_mug.png"), introduction: '疲れた身体に染み渡ります...。', genre_id: 3, price: 2, having_exp: 6 },
    {name: 'ハイボール', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/alcohol_highball_mug.png"), filename:"alcohol_highball_mug.png"), introduction: 'きりりと冷えています。', genre_id: 3, price: 2, having_exp: 5 },
    {name: 'レモンサワー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/alcohol_lemonsour_mug.png"), filename:"alcohol_lemonsour_mug.png"), introduction: '濃いめが嬉しいレモンサワーです。', genre_id: 3, price: 2, having_exp: 5 },
    {name: 'ホットコーヒー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drink_hotcoffee.png"), filename:"drink_hotcoffee.png"), introduction: '酸味と苦味のバランスが絶妙なこだわりのコーヒーです。', genre_id: 4, price: 2, having_exp: 3 },
    {name: 'アイスコーヒー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drink_icecoffee.png"), filename:"drink_icecoffee.png"), introduction: '酸味控えめのこだわりアイスコーヒーです。', genre_id: 4, price: 2, having_exp: 2 },
    {name: 'ホットティー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drink_hottea.png"), filename:"drink_hottea.png"), introduction: '芳醇で豊かな香りが口中に広がります。', genre_id: 4, price: 2, having_exp: 3 },
    {name: 'アイスティー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drink_icetea.png"), filename:"drink_icetea.png"), introduction: '紅茶の華やかな香り心地よいアイスティーです。', genre_id: 4, price: 2, having_exp: 4 },
    {name: 'タピオカいちごミルク', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drink_tapioca_ichigomilk_01.png"), filename:"drink_tapioca_ichigomilk_01.png"), introduction: 'モチモチのタピオカといちご果肉がたくさん入っています。', genre_id: 4, price: 4, having_exp: 3 },
    {name: 'クリームソーダ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/drink_creamsoda.png"), filename:"drink_creamsoda.png"), introduction: '甘く爽やかなメロンソーダに、アイスクリームがのっています。', genre_id: 4, price: 4, having_exp: 7 },
    {name: 'サンドイッチ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sandwich_potatosalad_ham_triangle.png"), filename:"sandwich_potatosalad_ham_triangle.png"), introduction: 'ハム、きゅうり、ポテトサラダを挟みました。', genre_id: 4, price: 4, having_exp: 3 },
    {name: 'トマトレタスバーガー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hamburger_tomato_lettuce_goma.png"), filename:"hamburger_tomato_lettuce_goma.png"), introduction: '溢れる肉汁とシャキシャキのレタス、トマトの酸味の相性がバツグン！', genre_id: 4, price: 5, having_exp: 3 },
    {name: 'ハヤシライス', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hayashirice.png"), filename:"hayashirice.png"), introduction: '自家製のコクのあるデミグラスソースにほろほろのお肉が入っています。', genre_id: 4, price: 6, having_exp: 3 },
    {name: 'オムライス', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/omurice_ketchup.png"), filename:"omurice_ketchup.png"), introduction: '洋食屋さん風オムライスです。', genre_id: 4, price: 4, having_exp: 2 },
    {name: 'パンケーキ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/pancake_namacream_mint_dish.png"), filename:"pancake_namacream_mint_dish.png"), introduction: 'モチモチのパンケーキに甘さ控えめの生クリームをのせました。', genre_id: 4, price: 6, having_exp: 6 },
    {name: 'マリトッツォ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/maritozzo_ichigo.png"), filename:"maritozzo_ichigo.png"), introduction: 'いちごと生クリームがたっぷり入ったマリトッツォです。', genre_id: 4, price: 3, having_exp: 1 },
    {name: '抹茶プリン', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/pudding_matcha_namacream.png"), filename:"pudding_matcha_namacream.png"), introduction: '宇治抹茶を使用した濃厚抹茶プリンです。', genre_id: 4, price: 3, having_exp: 3 },
    {name: 'チョコレートパフェ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/parfait_choco.png"), filename:"parfait_choco.png"), introduction: 'みんな大好きチョコレートパフェです。', genre_id: 4, price: 7, having_exp: 5 },
    {name: 'リス', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/risu_02.png"), filename:"risu_02.png"), introduction: '木の実を食べます。キュッと鳴きます。', genre_id: 5, price: 700, having_exp: 350 },
    {name: 'コアラ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/koala.png"), filename:"koala.png"), introduction: 'ユーカリを食べます。グルルルルと鳴きます。', genre_id: 5, price: 700, having_exp: 400 },
    {name: '白イルカ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/iruka_shiroiruka.png"), filename:"iruka_shiroiruka.png"), introduction: '魚を食べます。キュルルルルと鳴きます。', genre_id: 5, price: 700, having_exp: 450 },
    {name: 'ヤギ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yagi_shiroyagi.png"), filename:"yagi_shiroyagi.png"), introduction: '葉っぱを食べます。メ〜と鳴きます。', genre_id: 5, price: 700, having_exp: 370 },
    {name: 'オオカミ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/okami_gray.png"), filename:"okami_gray.png"), introduction: 'お肉を食べます。ワンと鳴きます。', genre_id: 5, price: 700, having_exp: 480 },
    {name: 'うさぎ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/usagi_pink.png"), filename:"usagi_pink.png"), introduction: '野菜を食べます。クークーと鳴きます。', genre_id: 5, price: 700, having_exp: 380 },
    {name: 'モルモット', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/morumotto_beige_white.png"), filename:"morumotto_beige_white.png"), introduction: '野菜を食べます。キュルキュルと鳴きます。', genre_id: 5, price: 700, having_exp: 400 },
    {name: 'ひよこ', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hiyoko.png"), filename:"hiyoko.png"), introduction: 'お米を食べます。ピヨピヨと鳴きます。', genre_id: 5, price: 700, having_exp: 460 },
    {name: 'ライオン', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/lion_male.png"), filename:"lion_male.png"), introduction: 'お肉を食べます。ガオ〜と鳴きます。', genre_id: 5, price: 700, having_exp: 420 },
    {name: 'トイプードル', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/dog_toypoodle_brown.png"), filename:"dog_toypoodle_brown.png"), introduction: 'ドッグフードを食べます。ワンと鳴きます。', genre_id: 5, price: 700, having_exp: 500 },
    {name: 'カンガルー', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kangaroo.png"), filename:"kangaroo.png"), introduction: '草を食べます。グオーと鳴きます。', genre_id: 5, price: 700, having_exp: 390 }
  ]
)