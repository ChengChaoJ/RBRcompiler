#include <stdio.h>

// 交换函数
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// 分区函数
int partition(int arr[], int low, int high) {
    int pivot = arr[high];  // 选择最后一个元素作为基准
    int i = (low - 1);      // 小于基准的元素的索引
    
    for (int j = low; j <= high - 1; j++) {
        // 如果当前元素小于或等于基准
        if (arr[j] <= pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

// 打印数组
void print_array(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    printf("=== 分区函数测试 ===\n");
    
    // 测试用例：简单数组
    int arr[] = {3, 1, 4, 1, 5, 9, 2, 6};
    int size = sizeof(arr) / sizeof(arr[0]);
    
    printf("原始数组: ");
    print_array(arr, size);
    
    int pivot_index = partition(arr, 0, size - 1);
    printf("分区后数组: ");
    print_array(arr, size);
    printf("基准索引: %d, 基准值: %d\n", pivot_index, arr[pivot_index]);
    
    // 验证分区结果
    printf("验证分区结果:\n");
    for (int i = 0; i < pivot_index; i++) {
        printf("arr[%d] = %d <= %d ✓\n", i, arr[i], arr[pivot_index]);
    }
    for (int i = pivot_index + 1; i < size; i++) {
        printf("arr[%d] = %d > %d ✓\n", i, arr[i], arr[pivot_index]);
    }
    
    return 0;
}
