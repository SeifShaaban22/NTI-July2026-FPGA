`timescale 1ns / 1ps

module tb_rising_edge_det;

    // 1. تعريف الإشارات (Inputs -> reg, Outputs -> wire)
    reg level;
    reg clk;
    wire moore_tick;
    wire mealy_tick;

    // 2. استدعاء الموديول المراد اختباره (DUT Initialization)
    rising_edge_det uut (
        .level(level),
        .clk(clk),
        .moore_tick(moore_tick),
        .mealy_tick(mealy_tick)
    );

    // 3. توليد إشارة الساعة (Clock Generation: Period = 10ns)
    always #5 clk = ~clk;

    // 4. تطبيق سيناريو الاختبار (Test Stimulus)
    initial begin
        // تهيئة القيم الأولية
        clk = 0;
        level = 0;

        // انتظام الإشارة لفترة قصيرة
        #15;

        // --- النبضة الأولى (First Rising Edge) ---
        level = 1; // هنا المفروض mealy_tick تظهر فوراً قبل الـ clk التالية
        #20;      // الابقاء على المستوى 1 لدورتين ساعة (نشوف moore_tick و الانتقال لـ one)
        level = 0; 
        #20;

        // --- النبضة الثانية (Second Rising Edge) ---
        level = 1;
        #10;
        level = 0; // نبضة سريعة مدتها دورة ساعة واحدة
        #20;

        // إنهاء المحاكاة
        $display("Simulation Finished Successfully!");
        $finish;
    end

    // 5. طباعة النتائج في الـ Terminal لمتابعة التغييرات
    initial begin
        $monitor("Time = %0t | clk = %b | level = %b | moore_tick = %b | mealy_tick = %b", 
                 $time, clk, level, moore_tick, mealy_tick);
    end

endmodule