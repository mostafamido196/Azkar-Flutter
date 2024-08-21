import 'dart:convert';

import 'package:azkar/core/FontSize.dart';
import 'package:azkar/core/error/failures.dart';
import 'package:azkar/features/ziker/data/datasources/SettingDataSorce.dart';
import 'package:azkar/features/ziker/domain/repositories/SettingRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/Setting.dart';
import '../models/HadithModel.dart';
import '../models/SettingModel.dart';
import '../models/ZikerModel.dart';

abstract class ZikerLocalDataSource {
  Future<List<ZikerResponse>> getZikerList();
}

class ZikerLocalDataSourceImpl implements ZikerLocalDataSource {

  @override
  Future<List<ZikerResponse>> getZikerList() {
    final listOfZikerModel = <ZikerResponse>[
      ZikerResponse(
          1,
          "أَذْكَارُ ما بعد الاسْتِيقَاظِ مِنَ النَّومِ",
          <HadithResponse>[
            HadithResponse(
              1,
              "يمسح آثار النوم عن وجهه بكفه ، وقراءة العشر الآيات الاخيرة من سورة ال عمران :﴿ إِنَّ فِي خَلْقِ السَّمَاوَاتِ وَالْأَرْضِ وَاخْتِلَافِ اللَّيْلِ وَالنَّهَارِ لَآيَاتٍ لِأُولِي الْأَلْبَابِ * ..... الآيات.",
              "البخاري 4569",
              1,
              0,
            ),
            HadithResponse(
                2,
                " (( الحَمْدُ للَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا، وَإِلَيْهِ النُّشُورُ)) وإذا انتبه من الليل قال: (( لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لهُ الْمُلْكُ وَلَهُ الحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللَّهِ، وَالحَمْدُ للَّهِ، وَلاَ إِلَهَ إِلاَّ اللَّهُ، وَاللَّهُ أَكبَرُ، وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ الْعَلِيِّ الْعَظِيمِ، رَبِّ اغْفرْ لِي))  \n  ",
                "البخاري 1154",
                1,
                0),
            HadithResponse(
                3,
                " الْحَمْدُ لِلَّهِ الَّذِي عَافَانِي فِي جَسَدِي، وَرَدَّ عَلَيَّ رُوحِي، وَأَذِنَ لِي بِذِكْرِه  ",
                "الترمذي 3401",
                1,
                0),
          ],
          ),
      ZikerResponse(
          2,
          "أَذْكَارُ الصباح",
          <HadithResponse>[
            HadithResponse(1, "قراءة الاخلاص والمعوذتين  ",
                "أخرجه أبو داود (5082) \"يقال ثلاث مرات.\"", 3, 0),
            HadithResponse(
                2,
                "أصبحتُ أثني عليك حمدًا وأشهدُ أن لا إله إلا الله.  ",
                "أخرجه النسائي (10406) \"يقال ثلاث مرات.\"",
                3,
                0),
            HadithResponse(
                3,
                "أصبَحنا على فطرة الإسلام، وكلمة الإخلاص، وسُّنة نبيِّنا محمد صلى الله عليه وسلم وملَّة أبينا إبراهيم، حنيفًا مسلمًا وما كان من المشركين. ",
                "أخرجه أحمد (15360)، الدارمي (2730)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                4,
                "اللهمَّ بك أصبَحنا، وبك أمسَينا، وبك نَحيا، وبك نموت، وإليك النشور.  ",
                "  أخرجه أبو داود (5068)، وابن حِبَّان (965) \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                5,
                "أصبَحنا وأصبَح المُلك لله، والحمد لله، لا إله إلا الله وحْده لا شريكَ له، له المُلك وله الحمد، وهو على كلِّ شيءٍ قدير، ربِّ أسألك خيرَ ما في هذا اليوم، وخيرَ ما بعده، وأعوذ بك من شرِّ هذا اليوم، وشرِّ ما بعده، ربِّ أعوذ بك من الكسل وسُوء الكِبَر، ربِّ أعوذ بك من عذابٍ في النار وعذابٍ في القبر.  ",
                "أخرَجه مسلم (2723)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                6,
                "لا إله إلا الله وحْده لا شريكَ له، له المُلك وله الحمد، وهو على كلِّ شيءٍ قدير.  ",
                "\"يقال عشرات مرات ، أو مرة واحدة عند الكسل ، ومائة مرة في اليوم\" أخرَجه أبو داود (5077)، والنسائي في اليوم والليلة (27)",
                100,
                0),
            HadithResponse(
                7,
                "اللهم فاطِرَ السماواتِ والأرضِ ، عالِمَ الغيبِ والشهادةِ ، ربَّ كلِّ شئٍ ومليكَهُ ، أشهد أن لا إله إلا أنت ، أعوذ بك من شرِّ نفسى ، ومن شرِّ الشيطانِ وشركه، وأن أقترف على نفسي سوءا، أو أجره إلى مسلم.  ",
                " أخرَجه أبو داود (5067)، والترمذي (3529)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                8,
                "اللهم إنى أسألك العافية فى الدنيا والآخرة ، اللهم إنى أسألك العفو والعافية فى دينى ، ودنياى ، وأهلى ، ومالى ، اللهم استر عَوْراتى ، وآمِن رَوْعاتي ، اللهم احفظنى من بين يدَىَّ ، ومن خلفى ، وعن يمينى ، وعن شمالى ، ومن فوقى ، وأعوذ بعظمتك أن أُغْتَالَ من تحتى.  ",
                "أخرَجه أبو داود (5074)، وابن ماجه (387)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                9,
                "اللهم إني أسألُك علمًا نافعًا ، ورزقًا طيبًا ، وعملًا متقبلًا.  ",
                "أخرجه ابن ماجه (٩٢٥)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(10, "سبحان الله وبحمده.  ",
                "أخرَجه مسلم (2692)\"يقال مائة مرة.\"", 100, 0),
            HadithResponse(
                11,
                "يا حي يا قيُّوم، برحمتك أستغيث، أصلِح لي شأني كلَّه، ولا تَكلني إلى نفسي طرْفة عين.  ",
                "أخرَجه النسائي في اليوم والليلة (570) \"يقال مرة واحدة\" ",
                1,
                0),
            HadithResponse(
                12,
                "اللهم أنت ربى لا إله إلا أنت خلقتنى وأنا عبدُكَ وأنا على عهدِكَ ووعدِكَ ما استطعتُ ، أعوذ بك من شرِّ ما صنعتُ ، أبوءُ لكَ بنعمتكَ علىَّ ، وأبوءُ لك بذنبى ؛ فاغفر لى ، فإنه لا يغفرُ الذنوب إلا أنت. ",
                "أخرَجه البخاري (6323) \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                13,
                "بسم الله الذى لا يضرُّ مع اسمه شئٌ فى الأرضِ ولا فى السماءِ وهو السميعُ العليم.  ",
                "أخرجه أبو داود (٥٠٨٨) ، الترمذي ( ٢٣٨٨ ) \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                14,
                "سبحان الله وبحمده عدد خلقه ، ورضا نفْسِهِ ، وزِنَةَ عرشه ، ومداد كلماته.  ",
                "أخرجه مسلم (2726) \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                15,
                "رضيتُ بالله ربًّا، وبالإسلام دينًا، وبمحمدٍ صلى الله عليه وسلم نبيًّا.  ",
                "أخرجه أبو داود (5072) \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                16,
                "اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْت.َ   ",
                "أخرجه أبو داود (5090)، أحمد (20430)، بإسناد يحسن بالمتابعات والشواهد. \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                17,
                "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ.  ",
                "أخرجه أبو داود (5090)، أحمد (20430)، بإسناد يحسن بالمتابعات والشواهد. \"يقال ثلاث مرات\"",
                3,
                0),
          ],
          ),
      ZikerResponse(
          3,
          "الاذكار والدعوات دبر الصلواتَ المكتوبات",
          [
            HadithResponse(
                1,
                "الله أكبر، الله أكبر، الله أكبر \n" +
                    "        (( مع رفع الصوت قليلا ))  ",
                "رواه البخاري (842) ، مسلم (583) ",
                1,
                0),
            HadithResponse(
                2,
                "أستغفرُ اللهَ ثلاثًا، اللهمَّ أنتَ السَّلامُ، ومنك السَّلامُ، تبارَكْتَ يا ذا الجلالِ والإكرامِ. ",
                "رواه مسلم (591) ",
                1,
                0),
            HadithResponse(
                3,
                "قراءةُ المُعوِّذاتِ (الإخلاصِ والفلقِ والنَّاسِ) ",
                "رواه أبو داود (1523)، وغيره. ",
                1,
                0),
            HadithResponse(
                4,
                "لا إلهَ إلَّا اللهُ وحده لا شريكَ له، له المُلكُ وله الحمدُ، وهو على كلِّ شيءٍ قديرٌ، اللهمَّ لا مانعَ لِما أعطَيْتَ، ولا مُعطِيَ لِما منَعْتَ، ولا ينفَعُ ذا الجَدِّ منك الجَدُّ.«مع رفع الصوت» ",
                "رواه البخاري (844)، ومسلم (593) ",
                1,
                0),
            HadithResponse(
                5,
                "لا إلهَ إلَّا اللهُ وحدَه لا شريكَ له، له المُلكُ وله الحمدُ، وهو على كلِّ شيءٍ قديرٌ، لا حولَ ولا قوَّةَ إلَّا باللهِ، لا إلهَ إلَّا اللهُ، ولا نعبُدُ إلَّا إيَّاهُ، له النِّعمةُ وله الفضلُ، وله الثَّناءُ الحَسَنُ، لا إلهَ إلَّا اللهُ مُخلِصينَ له الدِّينَ ولو كرِهَ الكافرونَ.«مع رفع الصوت» ",
                "رواه مسلم (594) ",
                1,
                0),
            HadithResponse(6, "ربِّ قِنِي عذابَك يومَ تبعَثُ عِبادَكَ. ",
                "رواه مسلم (709) ", 1, 0),
            HadithResponse(
                7,
                "اللهمَّ أعِنِّي على ذِكرِكَ وشُكرِكَ وحُسْنِ عبادتِكَ. ",
                "رواه أبو داود (1522)، وغيره. ",
                1,
                0),
            HadithResponse(
                8,
                "اللهم إنى أسألك فِعلَ الخيرات وتَرْكَ المنكرات وحُبَّ المساكين وإذا أردتَ بعبادك فتنةً فاقبضني إليك غير مفتون. ",
                "رواه الترمذي (3233)  ",
                1,
                0),
            HadithResponse(
                9,
                "التسبيح وصفاته أربعة:\n١- سُبحانَ اللهِ عشْرَ مرَّاتٍ، والحمدُ للهِ عشْرَ مرَّاتٍ، واللهُ أكبَرْ عشْرَ مرَّاتٍ.\nرواه البخاري (6329)، ومسلم (595)\nأو :\n٢- سُبحانَ اللهِ خَمْسًا وعشرينَ مرَّةً، والحمدُ للهِ خَمْسًا وعشرينَ مرَّةً، واللهُ أكبَرْ خَمْسًا وعشرينَ مرَّةً، ولا إلهَ إلَّا اللهُ خَمْسًا وعشرينَ مرَّةً.\nرواه الترمذي (3413)، وغيره.\nأو :\n٣- سُبحانَ اللهِ ثلاثًا وثلاثينَ مرَّةً، والحمدُ للهِ ثلاثًا وثلاثينَ مرَّةً، واللهُ أكبَرُ أربعًا وثلاثيَن مرَّةً.\nرواه مسلم (596)\nأو : \n٤- سُبحانَ اللهِ ثلاثًا وثلاثينَ، والحمدُ للهِ ثلاثًا وثلاثينَ، واللهُ أكبَرُ ثلاثًا وثلاثينَ، ولا إلهَ إلَّا اللهُ وحدَه لا شريكَ له، له المُلكُ وله الحمدُ، وهو على كلِّ شيءٍ قديرٌ، مرَّةً تمامَ المائةِ.\nرواه مسلم (597)\nفائدة:\nوله الجمعُ بينها فيقولُ: سُبحانَ اللهِ والحمدُ للهِ واللهُ أكبَرُ، هكذا، ثلاثًا وثلاثينَ مرَّة\n\nًصفة العَقْدِ بالأناملِ:\nيُسَنُّ أنْ يَعُدَّ التسبيحَ والتحميدَ والتكبيرَ بعقدِ أصابِعه،نصَّ على ذلك الحنابلةُ،وهو قولُ النَّوويُّ،وابنُ تيميَّة،وابنُ القيِّم،والشَّوكانيُّ، وابنُ بازٍ، وابنُ عُثَيْمين\nرواه أبو داود (1501)، وغيره .",
                "",
                33,
                0),
            HadithResponse(
                10,
                "اللهمَّ اغفِرْ لي ما قدَّمْتُ وما أخَّرْتُ، وما أسرَرْتُ وما أعلَنْتُ، وما أسرَفْتُ وما أنت أعلَمُ به منِّي، أنتَ المُقدِّمُ وأنتَ المُؤخِّرُ، لا إلهَ إلَّا أنتَ. ",
                "رواه أبو داود (1509)، وغيره. ",
                1,
                0),
            HadithResponse(
                11,
                "اللهمَّ إني أعوذُ بك مِن الجُبْنِ، وأعوذُ بك مِن البُخلِ، وأعوذُ بك مِن أنْ أُرَدَّ إلى أرذَلِ العُمُرِ، وأعوذُ بك مِن فتنةِ الدُّنيا وعذابِ القبرِ. ",
                "رواه البخاري(6374) ",
                1,
                0),
          ],
          ),
      ZikerResponse(
          4,
          "أَذْكَارُ المساء",
          [
            HadithResponse(1, "قراءة الاخلاص والمعوذتين  ",
                "أخرجه أبو داود (5082) \"يقال ثلاث مرات\"", 3, 0),
            HadithResponse(
                2,
                "اللهمَّ بك أمسَينا، وبك أصبَحنا، وبك نَحيا وبك نموت، وإليك المصير.  ",
                "  أخرجه أبو داود (5068)، وابن حِبَّان (965) \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                3,
                "أمسَينا وأمسى المُلك لله، والحمد لله، لا إله إلا الله وحْده لا شريك له، له المُلك وله الحمد، وهو على كلِّ شيءٍ قدير، ربِّ أسألك خيرَ ما في هذه الليلة وخيرَ ما بعدها، وأعوذ بك من شرِّ ما في هذه الليلة وشرِّ ما بعدها، ربِّ أعوذ بك من الكسل وسوء الكِبَر، ربِّ أعوذ بك من عذابٍ في النار وعذابٍ في القبر.  ",
                "أخرَجه مسلم (2723)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                4,
                "لا إله إلا الله وحْده لا شريكَ له، له المُلك وله الحمد، وهو على كلِّ شيءٍ قدير.  ",
                "\"يقال عشرات مرات ، أو مرة واحدة عند الكسل ، ومائة مرة في اليوم\" أخرَجه أبو داود (5077)، والنسائي في اليوم والليلة (27)",
                100,
                0),
            HadithResponse(
                5,
                "اللهم فاطِرَ السماواتِ والأرضِ ، عالِمَ الغيبِ والشهادةِ ، ربَّ كلِّ شئٍ ومليكَهُ ، أشهد أن لا إله إلا أنت ، أعوذ بك من شرِّ نفسى ، ومن شرِّ الشيطانِ وشركه، وأن أقترف على نفسي سوءا، أو أجره إلى مسلم.  ",
                " أخرَجه أبو داود (5067)، والترمذي (3529)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                6,
                "أمسينا على فطرة الإسلام، وكلمة الإخلاص، وسُّنة نبيِّنا محمد صلى الله عليه وسلم وملَّة أبينا إبراهيم، حنيفًا مسلمًا وما كان من المشركين.  ",
                " أخرَجه النسائي في اليوم والليلة (3)، والطبراني في الدعاء (293)،  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                7,
                "اللهم إنى أسألك العافية فى الدنيا والآخرة ، اللهم إنى أسألك العفو والعافية فى دينى ، ودنياى ، وأهلى ، ومالى ، اللهم استر عَوْراتى ، وآمِن رَوْعاتي ، اللهم احفظنى من بين يدَىَّ ، ومن خلفى ، وعن يمينى ، وعن شمالى ، ومن فوقى ، وأعوذ بعظمتك أن أُغْتَالَ من تحتى.  ",
                "أخرَجه أبو داود (5074)، وابن ماجه (387)  \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(8, "أعوذ بكلمات الله التامَّات من شرِّ ما خلَق.  ",
                "أخرَجه مسلم (2709)،   \"يقال ثلاث مرات\"", 3, 0),
            HadithResponse(9, "سبحان الله وبحمده  ",
                "أخرَجه مسلم (2692)\"يقال مائة مرة\"", 100, 0),
            HadithResponse(
                10,
                "يا حي يا قيُّوم، برحمتك أستغيث، أصلِح لي شأني كلَّه، ولا تَكلني إلى نفسي طرْفة عين.  ",
                "أخرَجه النسائي في اليوم والليلة (570) \"يقال مرة واحدة\" ",
                1,
                0),
            HadithResponse(
                11,
                "اللهم أنت ربى لا إله إلا أنت خلقتنى وأنا عبدُكَ وأنا على عهدِكَ ووعدِكَ ما استطعتُ ، أعوذ بك من شرِّ ما صنعتُ ، أبوءُ لكَ بنعمتكَ علىَّ ، وأبوءُ لك بذنبى ؛ فاغفر لى ، فإنه لا يغفرُ الذنوب إلا أنت.  ",
                "أخرَجه البخاري (6323) \"يقال مرة واحدة\"",
                1,
                0),
            HadithResponse(
                12,
                "بسم الله الذى لا يضرُّ مع اسمه شئٌ فى الأرضِ ولا فى السماءِ وهو السميعُ العليم.  ",
                "أخرجه أبو داود (٥٠٨٨) ، الترمذي ( ٢٣٨٨ ) \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                13,
                "رضيتُ بالله ربًّا، وبالإسلام دينًا، وبمحمدٍ صلى الله عليه وسلم نبيًّا.  ",
                "أخرجه أبو داود (5072) \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                14,
                "اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْت.َ   ",
                "أخرجه أبو داود (5090)، أحمد (20430)، بإسناد يحسن بالمتابعات والشواهد. \"يقال ثلاث مرات\"",
                3,
                0),
            HadithResponse(
                15,
                "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ.  ",
                "أخرجه أبو داود (5090)، أحمد (20430)، بإسناد يحسن بالمتابعات والشواهد \"يقال ثلاث مرات\"",
                3,
                0),
          ],
          ),
      ZikerResponse(
          5,
          "أَذْكَارُ ما قبل النَّومِ",
          [
            HadithResponse(
                1,
                "جمع الكفين والنفث فيهما مع قراءة ﴿ قُلْ هُوَ اللَّهُ أَحَدٌ ﴾ و﴿ قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ﴾ ، و﴿ قُلْ أَعُوذُ بِرَبِّ النَّاسِ ﴾ ، ثم يمسَح بهما ما استطاع من جسده، يبدأ بهما على رأسه ووجهه وما أقبل من جسده؛ يفعل ذلك ثلاث مرات. ",
                "«البخاري 5017» ",
                3,
                0),
            HadithResponse(2, "قراءة آية الكرسي. ", "«البخاري 2311» ", 1, 0),
            HadithResponse(
                3,
                "قراءة الآيتين من آخر سورة البقرة  ، فمَن قرأ بهما من ليلة كَفَتاه. ",
                "«البخاري 5009» ",
                1,
                0),
            HadithResponse(4, "قراءة : (سورتي بني إسرائيل- الإسراء - والزمر) ",
                "«الترمذي 2920» ", 1, 0),
            HadithResponse(
                5,
                "قراءة : ﴿ قُلْ يَا أَيُّهَا الْكَافِرُونَ ﴾ ، ثمَّ نم على خاتمتها؛ فإنها براءة من الشِّرك) ",
                "«أبو داود 5055» ",
                1,
                0),
            HadithResponse(
                6,
                "قراءة : ﴿ الم * تَنْزِيلُ ﴾ السجدة، و﴿ تَبَارَكَ الَّذِي بِيَدِهِ الْمُلْكُ ﴾ ",
                "«الترمذي 2892» ",
                1,
                0),
            HadithResponse(
                7,
                "وضع اليد تحتَ الخد ثم يقول: (( اللهم باسمك أموت وأحيا)) ",
                "«البخاري 6324» ",
                1,
                0),
            HadithResponse(
                8,
                "الله أكبر؛ أربعًا وثلاثين، وسبحان الله؛ ثلاثًا وثلاثين، والحمد لله؛ ثلاثًا وثلاثين. ",
                "«البخاري 5362» ",
                34,
                0),
            HadithResponse(
                9,
                "قول : (اللهمَّ أسلمتُ نفسي إليك، ووجهتُ وجهي إليك، وفوضتُ أمري إليك، وألجأتُ ظهري إليك، رغبة ورهبة إليك، لا ملجأ ولا منجى منك إلا إليك، آمنتُ بكتابك الذي أنزلتَ ونبيك الذي أرسلتَ) ",
                "«البخاري 6311» ",
                1,
                0),
            HadithResponse(
                10,
                "ينفض فراشه بداخِلَةِ إزاره أو بصنفة ثوبه ثلاثَ مرات ، ويقول: باسمك ربِّي وضعتُ جنبي وبك أرفعه، إن أمسكتَ نفسي فارحمها، أو (فاغفر لها)، وإن أرسلتَها فاحفظها بما تحفظ به عبادَك الصالحين) ",
                " «البخاري 6320»",
                1,
                0),
            HadithResponse(
                11,
                "قول:(الحمد لله الذي أطعَمَنا وسقانا، وكفانا وآوانا، فكم ممن لا كافي له ولا مؤوي) ",
                "«مسلم 2715»",
                1,
                0),
            HadithResponse(
                12,
                "قول: (( الحمد لله الذي كفاني، وآواني، وأطعمني، وسقاني، والذي مَنَّ عليَّ فأفضل، والذي أعطاني فأجزل، الحمد لله على كلِّ حال، اللهم رب كل شيء ومليكه، وإله كل شيء، أعوذ بك من النار)) ",
                "«أخرجه أحمد 185/8»",
                1,
                0),
            HadithResponse(
                13,
                "قول: (( اللهمَّ فاطر السموات والأرض، عالم الغيب والشهادة، رب كل شيء ومليكه، أشهد أن لا إله إلا أنت، أعوذ بك من شرِّ نفسي وشر الشيطان وشركه))، قال: (( قلها إذا أصبحتَ، وإذا أمسيتَ، وإذا أخذتَ مضجعك)) ",
                "«أبو داود 5069» ",
                1,
                0),
            HadithResponse(
                14,
                "قول: (( اللهمَّ قِني عذابك يوم تجمع أو تبعث عبادك)) ",
                "«الترمذي 3398» ",
                1,
                0),
            HadithResponse(
                15,
                "قول: (( أعوذ بكلمات الله التامَّة، من غضبه وعقابه، ومن شرِّ عباده، ومن همزات الشياطين، وأن يحضرون)) ",
                "«ابن السني 238» ",
                1,
                0),
            HadithResponse(
                16,
                "قول: (( اللهم رب السموات ورب الأرض ورب العرش العظيم، ربَّنا وربَّ كل شيء، فالق الحب والنَّوى ومنزل التوراة والإنجيل والفرقان، أعوذ بك من شر كل شيء أنت آخذ بناصيته، اللهم أنت الأول فليس قبلك شيء، وأنت الآخِر فليس بعدك شيء، وأنت الظاهر فليس فوقك شيء، وأنت الباطِن فليس دونك شيء، اقضِ عنا الدين وأغننا من الفقر)) ",
                "«مسلم 2713» ",
                1,
                0),
            HadithResponse(
                17,
                "قول: (( بسم الله وضعتُ جنبي، اللهمَّ اغفر لي ذنبي، وأخسئ شيطاني، وفكَّ رهاني، واجعلني في الندى الأعلى)) ",
                "«أبو داود 5054» ",
                1,
                0),
            HadithResponse(
                18,
                "قول: (( اللهم خلقتَ نفسي وأنت توفاها، لك مماتها ومحياها، إن أحييتَها فاحفظها وإن أمتَّها فاغفر لها، اللهمَّ إني أسألك العافية))، فقال له رجل: أسمعتَ هذا من عمر؟ فقال: من خير مِن عمر؛ من رسول الله صلى الله عليه وآله وسلم.",
                "«مسلم 2712»",
                1,
                0),
            HadithResponse(
                19,
                "قول: (( الحمد لله الذي كفاني وآواني، الحمد لله الذي أطعمني وسقاني، الحمد لله الذي مَنَّ عليَّ وأفضلَ، اللهمَّ إنِّي أسألك بعزَّتك أنْ تُنَجِّيَني من النَّار؛ فقدْ حَمِدَ الله بجميع محامدِ الخلقِ كلِّهم))",
                "«أخرجه الحاكم 546،545/1»",
                1,
                0),
            HadithResponse(
                20,
                "قول: (( اللهمَّ فاطِر السموات والأرض، عالمَ الغيب والشهادة، أنت ربُّ كل شيء، والملائكة يشهدون أنك لا إله إلا أنت، فإنا نعوذ بك من شرِّ أنفسنا، ومن شر الشيطان الرجيم وشركه، وأن نقترف سوءًا على أنفسنا أو نجرَّه إلى مسلم)) ",
                "«أبو داود 5083» ",
                1,
                0),
            HadithResponse(
                21,
                "قول: (( اللهمَّ فاطر السماوات والأرض، عالم الغيب والشهادة، رب كل شيء، وإله كل شيء، أشهد أن لا إله إلا أنت، وحدك لا شريك لك، وأن محمدًا عبدك ورسولك، والملائكة يشهدون، اللهمَّ إني أعوذ بك من الشيطان وشركه، وأعوذ بك أن أقرف على نفسي إثمًا، أو أرده إلى مسلم)) ",
                "«الطبراني في المعجم الكبير 94/40/13» ",
                1,
                0),
          ],
          ),
      ZikerResponse(
          6,
          "من جوامع الدعاء من الصحيحين",
          [
            HadithResponse(
                1,
                "اللهم اجعل في قلبي نورًا، وفي بصري نورًا، وفي سمعي نورًا، وعن يميني نورًا، وعن يساري نورًا، وفوقي نورًا، وتحتي نورًا، وأمامي نورًا، وخلفي نورًا، واجعل لي نورًا. ",
                "متفق عليه (البخاري 6316، مسلم 763)",
                1,
                0),
            HadithResponse(
                2,
                "اللَّهمَّ إِنِّي ظَلَمْتُ نَفْسِي ظُلْمًا كثِيرًا، وَلا يَغْفِر الذُّنوبَ إِلَّا أَنْتَ، فَاغْفِر لي مغْفِرَةً مِن عِنْدِكَ، وَارحَمْني، إِنَّكَ أَنْتَ الْغَفور الرَّحِيم. ",
                "متفق عليه (البخاري 834، مسلم2705)",
                1,
                0),
            HadithResponse(
                3,
                "اللَّهمَّ اغْفِر لي خَطِيئَتي وجَهْلي، وإِسْرَافي في أَمْري، وما أَنْتَ أَعلَم بِهِ مِنِّي، اللَّهمَّ اغفِرْ لي جِدِّي وَهَزْلي، وَخَطَئي وَعمْدِي، وَكلُّ ذلِكَ عِنْدِي، اللَّهُمَّ اغْفِرْ لي مَا قَدَّمْتُ وَمَا أَخَّرْتُ، وَما أَسْررْتُ وَمَا أَعْلَنْتُ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّي، أَنْت المقَدِّمُ، وَأَنْتَ المُؤَخِّرُ، وَأَنْتَ عَلى كلِّ شَيْءٍ قَدِيرٌ.",
                "متفق عليه (البخاري 6398، مسلم 2719)",
                1,
                0),
            HadithResponse(
                4,
                "اللَّهُمَّ لَكَ أسْلَمْتُ، وبِكَ آمنْتُ، وعليكَ توَكَّلْتُ، وإلَيكَ أنَبْتُ، وبِكَ خاصَمْتُ، اللَّهُمَّ أعُوذُ بِعِزَّتِكَ، لا إلَه إلَّا أنْتَ أنْ تُضِلَّنِي، أنْت الْحيُّ الَّذي لا تمُوتُ، وَالْجِنُّ وَالإِنْسُ يمُوتُونَ.",
                "متفق عليه (البخاري 7383، مسلم 2717)",
                1,
                0),
            HadithResponse(
                5,
                "اللهُمَّ لك الحمد، أنت ربُّ السماوات والأرض، لك الحمد، أنت قيِّم السماوات والأرض ومَن فيهنَّ، لك الحمد أنت نور السماوات والأرض، قولك الحق، ووعدُك الحق، ولقاؤك حق، والجنة حق، والنار حق، والساعة حق، اللهُمَّ لك أسلمتُ، وبك آمنت، وعليك توكَّلت، وإليك أنبْتُ، وبك خاصمتُ، وإليك حاكمتُ؛ فاغفر لي ما قدَّمت وما أخَّرت، وأسررتُ وأعلنت، أنت إلهي لا إله لي غيرك.",
                "متفق عليه (البخاري 7385، مسلم769)",
                1,
                0),
            HadithResponse(
                6,
                "اللهُمَّ إني أعوذ بك من الكسل والهرَم، والمأثم والمغرَم، ومن فتنة القبر وعذابِ القبر، ومن فتنة النار وعذاب النار، ومن شرِّ فتنة الغِنى، وأعوذ بك من فتنة الفقر، وأعوذ بك من فتنة المسيح الدَّجَّال، اللهم اغسل عني خطايايَ بماء الثلج والبَرَد، ونقِّ قلبي من الخطايا كما نقَّيْتَ الثوب الأبيض من الدَّنَس، وباعِدْ بيني وبين خطاياي كما باعدتَ بين المشرق والمغرب.",
                "متفق عليه (البخاري 6368، مسلم 589)",
                1,
                0),
            HadithResponse(
                7,
                "عن النَّبِيِّ صَلَّى اللهُ عَلَيْهِ وسَلَّم قَالَ: (( تَعَوَّذُوا بِاللَّهِ مِنْ جَهْدِ الْبَلاءِ، وَدَرَكِ الشَّقَاءِ، وَسُوءِ الْقَضَاءِ، وَشَماتَةِ الأَعْدَاءِ))",
                "متفق عليه (البخاري 6616، مسلم 2707)",
                1,
                0),
            HadithResponse(
                8,
                "اللهُمَّ إني أعوذُ بك من فتنة النار، ومن عذاب النار، وأعوذ بك من فتنة القبر، وأعوذ بك من عذاب القبر، وأعوذ بك من فتنة الغِنى، وأعوذ بك من فتنة الفقر، وأعوذ بك من فتنة المسيح الدَّجَّال.",
                "متفق عليه (البخاري 6376، مسلم 589)",
                1,
                0),
            HadithResponse(
                9,
                "كانَ أَكْثَرُ دُعَاءِ النبيِّ صَلَّى اللهُ عَلَيْهِ وسَلَّم: (( اللَّهُمَّ آتِنَا في الدُّنْيَا حَسَنَةً، وفي الآخِرةِ حَسنَةً، وَقِنَا عَذابَ النَّارِ))",
                "متفق عليه (البخاري 4522، مسلم 2690)",
                1,
                0),
            HadithResponse(
                10,
                "قَالَ النَّبِيُّ صلى الله عليه وسلم: (( لَا يَتَمَنَّيَنَّ أَحَدُكُمُ الْمَوْتَ مِنْ ضُرٍّ أَصَابَهُ، فَإِنْ كَانَ لَا بُدَّ فَاعِلًا فَلْيَقُلِ: اللَّهُمَّ أَحْيِنِي مَا كَانَتِ الْحَيَاةُ خَيْرًا لِي، وَتَوَفَّنِي إِذَا كَانَتِ الْوَفَاةُ خَيْرًا لِي))",
                "متفق عليه (البخاري 5671، مسلم 2680)",
                1,
                0),
            HadithResponse(
                11,
                "اللهُمَّ ربَّ الناس مُذهِبَ الباس، اشْفِ أنت الشافي، لا شافي إلا أنت، شفاءً لا يُغادر سقمًا.",
                "(البخاري 5742)",
                1,
                0),
            HadithResponse(
                12,
                "سيِّد الاستغفار أن تقول: (( اللهُمَّ أنت ربِّي، لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شَرِّ ما صنعت، أبوء لك بنعمتك عليَّ، وأبوء لك بذنبي، فاغفر لي، فإنه لا يغفر الذنوب إلا أنت))، قال: (( ومَنْ قالها من النهار موقِنًا بها، فمات من يومه قبل أن يُمْسي، فهو من أهل الجنة، ومَنْ قالَها مِنَ الليل وهو موقِن بها، فمات قبل أن يُصبِح، فهو من أهل الجنة))",
                "(البخاري 6306)",
                1,
                0),
            HadithResponse(
                13,
                "اللهُمَّ باعِدْ بيني وبين خطاياي كما باعدتَ بين المشرق والمغرب، اللهُمَّ نقِّني من خطاياي كما يُنقَّى الثوبُ الأبيضُ مِن الدَّنَس، اللهُمَّ اغسِلْني من خطاياي بالثلج والماء والبَرَد.",
                "متفق عليه (البخاري 744، مسلم 598)",
                1,
                0),
            HadithResponse(
                14,
                "اللهُمَّ أعوذ برضاك مِن سخَطِك، وبمعافاتك من عقوبتك، وأعوذ بك منك، لا أُحْصي ثناءً عليك، أنتَ كما أثنيت على نفسك.",
                "(مسلم 486)",
                1,
                0),
            HadithResponse(
                15, "ربِّ، قِني عذابَك يوم تبعثُ عبادَك.", "(مسلم 709)", 1, 0),
            HadithResponse(
                16,
                "أعوذ بكلماتِ اللهِ التامَّاتِ مِنْ شَرِّ ما خَلَق.",
                "(مسلم 2709)",
                1,
                0),
            HadithResponse(
                17,
                "أعوذُ باللهِ مِنَ الفِتَنِ؛ ما ظهَرَ منها وما بَطَن.",
                "(مسلم 2867)",
                1,
                0),
            HadithResponse(
                18,
                "اللهُمَّ ربَّ جبرائيل وميكائيل وإسرافيل، فاطر السموات والأرض، عالم الغيب والشهادة، أنت تحكم بين عبادك فيما كانوا فيه يختلفون، اهدِني لما اختُلِف فيه من الحقِّ بإذنك؛ إنك تهدي مَن تشاء إلى صراطٍ مستقيمٍ.",
                "(مسلم 770)",
                1,
                0),
            HadithResponse(
                19,
                "اللهُمَّ أنت الملك، لا إله إلا أنت، أنت ربي، وأنا عَبْدُك، ظلمتُ نفسي، واعترفت بذنبي، فاغفر لي ذنوبي جميعًا، إنه لا يغفر الذنوب إلا أنت، واهدِني لأحسن الأخلاق، لا يهدي لأحسنها إلا أنت، واصرِف عني سيِّئَها، لا يصرف عني سيئها إلا أنت، لبَّيْك وسعديك، والخير كلُّه في يديك، والشرُّ ليس إليك، أنا بكَ وإليك، تباركتَ وتعاليت، أستغفرك وأتوب إليك.",
                "(مسلم 771)",
                1,
                0),
            HadithResponse(
                20,
                "اللهُمَّ ربَّ السموات وربَّ الأرض وربَّ العرش العظيم، ربنا ورب كل شيءٍ، فالقَ الحَبِّ والنَّوى، ومنزلَ التوراة والإنجيل والفُرْقان، أعوذ بك من شرِّ كل شيءٍ أنت آخذٌ بناصيته.",
                "(مسلم 2713)",
                1,
                0),
            HadithResponse(
                21,
                "اللهُمَّ أنت الأوَّلُ فليس قبلك شيء، وأنت الآخِرُ فليس بعدك شيء، وأنت الظاهر فليس فوقك شيء، وأنت الباطن فليس دونك شيء؛ اقضِ عنا الدَّين، وأغنِنا من الفقر.",
                "(مسلم 2713)",
                1,
                0),
            HadithResponse(
                22,
                "اللهُمَّ مُنْزِلَ الكتاب، ومجرِيَ السحاب، وهازم الأحزاب، اهزمهم، وانصرنا عليهم.",
                "متفق عليه (البخاري 3025، مسلم 1742)",
                1,
                0),
            HadithResponse(
                23,
                "اللهُمَّ إني أعوذ بك من زوال نعمتك، وتحوُّل عافيتك، وفُجاءة نِقْمتك، وجميع سخَطك.",
                "(مسلم 2739)",
                1,
                0),
            HadithResponse(
                24,
                "اللهُمَّ إني أعوذ بك من شَرِّ ما عَمِلتُ، ومن شَرِّ ما لم أعمل.",
                "(مسلم 2716)",
                1,
                0),
            HadithResponse(
                25,
                "اللهُمَّ مُصرِّف القلوب، صرِّف قلوبنا على طاعتك.",
                "(مسلم 2654)",
                1,
                0),
            HadithResponse(
                26,
                "كان رسولُ اللَّه صلى الله عليه وسلم يُكْثِرُ أنْ يَقولَ قبْلَ أَنْ يَمُوتَ: (( سُبْحانَكَ اللَّهُمَّ وبِحْمدِكَ، أسْتَغْفِركَ وأتُوبُ إلَيْكَ))",
                "(مسلم 484)",
                1,
                0),
            HadithResponse(
                27,
                "قالَ رَسُولُ اللَّه صلى الله عليه وسلم: (( لأن أَقُولَ سبْحانَ اللَّهِ، وَالحَمْدُ للَّهِ، ولا إلَه إلَّا اللَّه، وَاللَّه أكْبرُ، أَحبُّ إليَّ مِمَّا طَلَعَت عليهِ الشَّمْسُ))",
                "(مسلم 2695)",
                1,
                0),
            HadithResponse(
                28,
                "جاءَ أَعْرَابي إلى رسُولِ اللَّه صلى الله عليه وسلم فقالَ: علِّمْني كَلامًا أَقُولُهُ، قالَ: (( قُل لا إله إلَّا اللَّه وحدَهُ لا شرِيكَ لهُ، اللَّه أَكْبَرُ كَبِيرًا، والحمْدُ للَّهِ كَثيرًا، وسُبْحانَ اللَّه ربِّ العالمِينَ، ولا حوْل وَلا قُوَّةَ إلَّا باللَّهِ العَزيز الحكيمِ))، قال: فَهؤلاء لِرَبِّي، فَما لي؟ قال: (( قُل: اللَّهُمَّ اغْفِرْ لي وارْحمني، واهْدِني، وارْزُقْني))",
                "(مسلم 2696)",
                1,
                0),
            HadithResponse(
                29,
                "َانَ الرَّجلُ إِذا أَسْلَمَ عَلَّمَهُ النَّبيُّ صلى الله عليه وسلم الصَّلاةَ، ثُمَّ أَمَرَهُ أَنْ يَدعُوَ بهَؤُلاءِ الكَلِمَاتِ: (( اللَّهُمَّ اغفِرْ لي، وَارْحمْني، واهْدِني، وعافِني، وارْزُقني))",
                "(مسلم 2697)",
                1,
                0),
            HadithResponse(
                30,
                "اللَّهُمَّ أَصْلِحْ لي دِيني الَّذي هُوَ عِصْمَةُ أَمْرِي، وأَصْلِحْ لِي دُنْيَايَ التي فِيهَا مَعَاشِي، وَأَصْلِحْ لي آخِرَتي الَّتي فِيها معادي، وَاجْعلِ الحيَاةَ زِيادَةً لي في كُلِّ خَيْرٍ، وَاجْعَلِ الموتَ راحَةً لي مِنْ كُلِّ شَرٍّ.",
                "(مسلم 2720)",
                1,
                0),
            HadithResponse(
                31,
                "عنْ عليٍّ رَضِيَ اللَّه عَنْهُ، قَالَ: قال لي رَسُولُ اللَّهِ صلى الله عليه وسلم: (( قُلْ: اللَّهُمَّ اهْدِني، وَسدِّدْني))\n وَفي رِوَايةٍ: (( اللَّهُمَّ إِنِّي أَسْأَلُكَ الْهُدى، وَالسَّدَادَ))",
                "(مسلم 2725)",
                1,
                0),
            HadithResponse(
                32,
                "اللهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ العَجْزِ وَالكَسَلِ، والبُخْلِ وَالهَرم، وعَذَاب الْقَبْر، اللَّهُمَّ آتِ نَفْسِي تَقْوَاهَا، وَزَكِّهَا أَنْتَ خَيرُ مَنْ زَكَّاهَا، أَنْتَ ولِيُّهَا وَموْلاهَا، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ عِلمٍ لا يَنْفَعُ، ومِنْ قَلْبٍ لا يخْشَعُ، وَمِنْ نَفْسٍ لا تَشبَعُ، ومِنْ دَعْوةٍ لا يُسْتجابُ لهَا.",
                "(مسلم 2722)",
                1,
                0),
            HadithResponse(
                33,
                "اللَّهُمَّ إِنِّـي أَعُوذُ بِكَ مِنَ الْعجْزِ والكَسَلِ وَالجُبْنِ وَالهَرَمِ، وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ القبْرِ، وَأَعُوذُ بِكَ مِنْ فِتْنَةِ المَحْيا وَالمَمَاتِ.\nوفي رِوايةٍ: (( وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ))",
                "متفق عليه (البخاري 6369، مسلم 2706)",
                1,
                0),
            HadithResponse(
                34,
                "اللَّهُمَّ إِنِّي أَسْأَلُكَ الهُدَى، وَالتُّقَى، وَالعفَافَ، والغِنَى.",
                "(مسلم 2721)",
                1,
                0),
          ],
          )
    ];

    return Future.value(listOfZikerModel);
  }

}
