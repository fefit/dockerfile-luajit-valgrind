#include <stdlib.h>;
typedef struct ArrayData
{
  int *data;
  size_t n;
} NArray;

NArray *make_n(int n)
{
  NArray *result = (NArray *)malloc(sizeof(NArray));
  if (result != NULL)
  {
    result->n = n;
    int *array = result->data = (int *)malloc(n * sizeof(int));
    if (array != NULL)
    {
      for (int i = 0; i < n; i++)
      {
        array[i] = i;
      }
    }
  }
  return result;
}

void free_n_array(NArray *arr)
{
  if (arr)
  {
    if (arr->data)
    {
      free(arr->data);
    }
    free(arr);
    arr = NULL;
  }
}