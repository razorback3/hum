; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt < %s -argpromotion -S | FileCheck %s
; RUN: opt < %s -passes=argpromotion -S | FileCheck %s

target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

%struct.ss = type { i32, i64 }

define internal void @f(%struct.ss* byval  %b) nounwind  {
; CHECK-LABEL: define {{[^@]+}}@f
; CHECK-SAME: (i32 [[B_0:%.*]], i64 [[B_1:%.*]])
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_SS:%.*]]
; CHECK-NEXT:    [[DOT0:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[B]], i32 0, i32 0
; CHECK-NEXT:    store i32 [[B_0]], i32* [[DOT0]]
; CHECK-NEXT:    [[DOT1:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[B]], i32 0, i32 1
; CHECK-NEXT:    store i64 [[B_1]], i64* [[DOT1]]
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[B]], i32 0, i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[TMP]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[TMP1]], 1
; CHECK-NEXT:    store i32 [[TMP2]], i32* [[TMP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %tmp = getelementptr %struct.ss, %struct.ss* %b, i32 0, i32 0
  %tmp1 = load i32, i32* %tmp, align 4
  %tmp2 = add i32 %tmp1, 1
  store i32 %tmp2, i32* %tmp, align 4
  ret void
}


define internal void @g(%struct.ss* byval align 32 %b) nounwind {
; CHECK-LABEL: define {{[^@]+}}@g
; CHECK-SAME: (i32 [[B_0:%.*]], i64 [[B_1:%.*]])
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B:%.*]] = alloca [[STRUCT_SS:%.*]], align 32
; CHECK-NEXT:    [[DOT0:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[B]], i32 0, i32 0
; CHECK-NEXT:    store i32 [[B_0]], i32* [[DOT0]]
; CHECK-NEXT:    [[DOT1:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[B]], i32 0, i32 1
; CHECK-NEXT:    store i64 [[B_1]], i64* [[DOT1]]
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[B]], i32 0, i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[TMP]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[TMP1]], 1
; CHECK-NEXT:    store i32 [[TMP2]], i32* [[TMP]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %tmp = getelementptr %struct.ss, %struct.ss* %b, i32 0, i32 0
  %tmp1 = load i32, i32* %tmp, align 4
  %tmp2 = add i32 %tmp1, 1
  store i32 %tmp2, i32* %tmp, align 4
  ret void
}


define i32 @main() nounwind  {
; CHECK-LABEL: define {{[^@]+}}@main()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[S:%.*]] = alloca [[STRUCT_SS:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[S]], i32 0, i32 0
; CHECK-NEXT:    store i32 1, i32* [[TMP1]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[S]], i32 0, i32 1
; CHECK-NEXT:    store i64 2, i64* [[TMP4]], align 4
; CHECK-NEXT:    [[S_0:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[S]], i32 0, i32 0
; CHECK-NEXT:    [[S_0_VAL:%.*]] = load i32, i32* [[S_0]]
; CHECK-NEXT:    [[S_1:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[S]], i32 0, i32 1
; CHECK-NEXT:    [[S_1_VAL:%.*]] = load i64, i64* [[S_1]]
; CHECK-NEXT:    call void @f(i32 [[S_0_VAL]], i64 [[S_1_VAL]])
; CHECK-NEXT:    [[S_01:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[S]], i32 0, i32 0
; CHECK-NEXT:    [[S_01_VAL:%.*]] = load i32, i32* [[S_01]]
; CHECK-NEXT:    [[S_12:%.*]] = getelementptr [[STRUCT_SS]], %struct.ss* [[S]], i32 0, i32 1
; CHECK-NEXT:    [[S_12_VAL:%.*]] = load i64, i64* [[S_12]]
; CHECK-NEXT:    call void @g(i32 [[S_01_VAL]], i64 [[S_12_VAL]])
; CHECK-NEXT:    ret i32 0
;
entry:
  %S = alloca %struct.ss
  %tmp1 = getelementptr %struct.ss, %struct.ss* %S, i32 0, i32 0
  store i32 1, i32* %tmp1, align 8
  %tmp4 = getelementptr %struct.ss, %struct.ss* %S, i32 0, i32 1
  store i64 2, i64* %tmp4, align 4
  call void @f(%struct.ss* byval %S) nounwind
  call void @g(%struct.ss* byval %S) nounwind
  ret i32 0
}

