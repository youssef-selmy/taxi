 
export default {
  displayName: 'payment-gateways',
  transform: {
    '^.+\\.[tj]s$': 'ts-jest',
  },
  moduleNameMapper: {
    '^uuid$': require.resolve('uuid'),
  },
  moduleFileExtensions: ['ts', 'js', 'html'],
  coverageDirectory: '../../coverage/apps/payment-gateways',
  testEnvironment: 'node',
  preset: '../../jest.preset.js',
};
