import type { itemtype } from '@prisma/client';

export const itemEnumValueToString = (itemEnum: itemtype): string => {
  let itType = null;

  switch (itemEnum) {
    case 'CROSS_COUNTRY':
      itType = 'Беговые кроссовки';
      break;
    case 'BASKETBALL':
      itType = 'Баскетбольные кроссовки';
      break;
    case 'FOOTBALL':
      itType = 'Футбольные кроссовки';
      break;
    case 'EVERYDAY':
      itType = 'Повседневные кроссовки';
      break;
    case 'TENNIS':
      itType = 'Теннисные кроссовки';
      break;
    case 'FOR_FITNESS':
      itType = 'Для фитнеса';
      break;
    case 'SKATER':
      itType = 'Скейтерские кроссовки';
      break;
    case 'FOR_TOURISM':
      itType = 'Для туризма и активного отдыха';
  }

  return itType;
};

export const addSpaceInString = (inputString: string): string => {
  if (inputString.length <= 3) {
    return inputString;
  }

  const insertionPoint = inputString.length - 3;
  const partBeforeInsertion = inputString.slice(0, insertionPoint);
  const partAfterInsertion = inputString.slice(insertionPoint);

  const stringWithSpace = `${partBeforeInsertion} ${partAfterInsertion}`;

  return stringWithSpace;
};
